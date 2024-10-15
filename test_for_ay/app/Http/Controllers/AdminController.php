<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use App\Models\BasketProduct;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class AdminController extends Controller
{
    // إدارة التصنيفات
    // 1. إضافة تصنيف جديد
    public function addCategory(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('category_images', 'public');
        }

        $category = Category::create([
            'name' => $request->input('name'),
            'image_path' => $imagePath,
        ]);

        return response()->json(['message' => 'Category added successfully', 'category' => $category], 201);
    }

    // 2. تعديل تصنيف موجود
    public function updateCategory(Request $request, $id)
    {
        $category = Category::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $imagePath = $category->image_path;
        if ($request->hasFile('image')) {
            if ($imagePath) {
                Storage::disk('public')->delete($imagePath);  // حذف الصورة القديمة
            }
            $imagePath = $request->file('image')->store('category_images', 'public');
        }

        $category->update([
            'name' => $request->input('name'),
            'image_path' => $imagePath,
        ]);

        return response()->json(['message' => 'Category updated successfully', 'category' => $category]);
    }

    // 3. حذف تصنيف
    public function deleteCategory($id)
    {
        $category = Category::findOrFail($id);
        
        // حذف الصورة إن وجدت
        if ($category->image_path) {
            Storage::disk('public')->delete($category->image_path);
        }

        $category->delete();

        return response()->json(['message' => 'Category deleted successfully']);
    }

    // إدارة المنتجات
    // 1. إضافة منتج جديد
    public function addProduct(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('product_images', 'public');
        }

        $product = Product::create([
            'name' => $request->input('name'),
            'description' => $request->input('description'),
            'price' => $request->input('price'),
            'category_id' => $request->input('category_id'),
            'image_path' => $imagePath,
        ]);

        return response()->json(['message' => 'Product added successfully', 'product' => $product], 201);
    }

    // 2. تعديل منتج موجود
    public function updateProduct(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric|min:0',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $imagePath = $product->image_path;
        if ($request->hasFile('image')) {
            if ($imagePath) {
                Storage::disk('public')->delete($imagePath);  // حذف الصورة القديمة
            }
            $imagePath = $request->file('image')->store('product_images', 'public');
        }

        $product->update([
            'name' => $request->input('name'),
            'description' => $request->input('description'),
            'price' => $request->input('price'),
            'category_id' => $request->input('category_id'),
            'image_path' => $imagePath,
        ]);

        return response()->json(['message' => 'Product updated successfully', 'product' => $product]);
    }

    // 3. حذف منتج
    public function deleteProduct($id)
    {
        $product = Product::findOrFail($id);
        
        // حذف الصورة إن وجدت
        if ($product->image_path) {
            Storage::disk('public')->delete($product->image_path);
        }

        $product->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }

    // إحصاءات وتقارير
    public function getStatistics()
    {
        // 1. المنتجات الأكثر مبيعاً
        $topProducts = BasketProduct::selectRaw('product_id, SUM(quantity) as total_quantity')
                                     ->groupBy('product_id')
                                     ->orderBy('total_quantity', 'desc')
                                     ->with('product')
                                     ->limit(10)
                                     ->get();

        // 2. المستخدمين النشطين
        $activeUsers = User::withCount(['baskets'])
                           ->orderBy('baskets_count', 'desc')
                           ->limit(10)
                           ->get();

        // 3. المنتجات المتروكة في السلة لفترة طويلة
        $abandonedProducts = BasketProduct::where('created_at', '<', now()->subDays(30))
                                          ->with('product')
                                          ->get();

        return response()->json([
            'top_products' => $topProducts,
            'active_users' => $activeUsers,
            'abandoned_products' => $abandonedProducts
        ]);
    }
}

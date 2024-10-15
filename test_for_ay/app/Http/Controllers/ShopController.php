<?php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use App\Models\Basket;
use App\Models\BasketProduct;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ShopController extends Controller
{
    public function getCategories()
    {
        $categories = Category::all();  
        return response()->json($categories);
    }

    public function getProductsByCategory($categoryId)
    {
        $products = Product::where('category_id', $categoryId)->get(); 
        return response()->json($products);
    }

    public function getProductDetails($productId)
    {
        $product = Product::find($productId);   
        if ($product) {
            return response()->json($product);
        } 
        return response()->json(['message' => 'Product not found'], 404);
    }

    // // 4. إضافة المنتجات إلى سلة التسوق
    // public function addToBasket(Request $request)
    // {
    //     $userId = Auth::id();  // الحصول على معرّف المستخدم المسجل
    //     $productId = $request->input('product_id');
    //     $quantity = $request->input('quantity', 1);

    //     // جلب السلة الخاصة بالمستخدم أو إنشاؤها
    //     $basket = Basket::firstOrCreate(['user_id' => $userId]);

    //     // التحقق إذا كان المنتج موجود بالفعل في السلة
    //     $basketProduct = BasketProduct::where('basket_id', $basket->id)
    //                                    ->where('product_id', $productId)
    //                                    ->first();
 
    //     if ($basketProduct) {
    //         // إذا كان المنتج موجود، يتم تحديث الكمية
    //         $basketProduct->quantity += $quantity;
    //         $basketProduct->save();
    //     } else {
    //         // إذا لم يكن المنتج موجود، يتم إضافته للسلة
    //         BasketProduct::create([
    //             'basket_id' => $basket->id,
    //             'product_id' => $productId,
    //             'quantity' => $quantity,
    //         ]);
    //     }

    //     return response()->json(['message' => 'Product added to basket']);
    // }

    // // 5. عرض محتويات سلة التسوق
    // public function getBasket()
    // {
    //     $userId = Auth::id();  // الحصول على معرّف المستخدم
    //     $basket = Basket::where('user_id', $userId)->first();

    //     if ($basket) {
    //         $products = BasketProduct::where('basket_id', $basket->id)
    //                                   ->with('product') // جلب تفاصيل المنتج مع الكمية
    //                                   ->get();

    //         $totalPrice = 0;
    //         foreach ($products as $product) {
    //             $totalPrice += $product->quantity * $product->product->price;  // حساب السعر الإجمالي
    //         }

    //         return response()->json([
    //             'products' => $products,
    //             'total_price' => $totalPrice
    //         ]);
    //     }

    //     return response()->json(['message' => 'Basket is empty']);
    // }

    // // 6. حذف منتج من السلة
    // public function removeFromBasket($productId)
    // {
    //     $userId = Auth::id();  // الحصول على معرّف المستخدم
    //     $basket = Basket::where('user_id', $userId)->first();

    //     if ($basket) {
    //         $basketProduct = BasketProduct::where('basket_id', $basket->id)
    //                                       ->where('product_id', $productId)
    //                                       ->first();

    //         if ($basketProduct) {
    //             $basketProduct->delete();  // حذف المنتج من السلة
    //             return response()->json(['message' => 'Product removed from basket']);
    //         }
    //     }

    //     return response()->json(['message' => 'Product not found in basket'], 404);
    // }

    // // 7. إفراغ السلة بالكامل
    // public function clearBasket()
    // {
    //     $userId = Auth::id();  // الحصول على معرّف المستخدم
    //     $basket = Basket::where('user_id', $userId)->first();

    //     if ($basket) {
    //         BasketProduct::where('basket_id', $basket->id)->delete();  // حذف جميع المنتجات من السلة
    //         return response()->json(['message' => 'Basket cleared']);
    //     }

    //     return response()->json(['message' => 'Basket is empty'], 404);
    // }
}

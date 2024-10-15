<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;

class CategoriesTableSeeder extends Seeder
{
    public function run()
    {
        $faker = Faker::create();

        foreach (range(1, 5) as $index) {
            DB::table('categories')->insert([
                'name' => $faker->word,
                'image_path' => $faker->image('public/storage/category_images', 640, 480, null, true),
            ]);
        }
    }
}

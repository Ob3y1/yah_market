<html>
    <head>
        <title>@yield('title')</title>
    </head>
    <body>
        <div style="border:1px solid black; background-color:lightgray;">
            <h1>Page Header</h1>
        </div><br>
        <div class="container" style="border:1px solid red; height:500px;">
            @yield('content')
        </div><hr>
        <div style="text-align:center; background-color:lightgray;">
        @yield('footer')page footer     
      </div>
    </body>
</html>

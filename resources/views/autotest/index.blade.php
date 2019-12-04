<html>
    <body>
        <h1>Example for test</h1>
        @if(count($autotest_data))
            <ul>
                @foreach($autotest_data as $key => $autotest)
                    <li>Number A: {{ $autotest->number_a }}, Number B: {{ $autotest->number_b }}</li>
                @endforeach
            </ul>
        @endif
        <hr>
        <form method="POST" action="/autotest/example">
            @csrf
            Number A: <input type="" name="number_a">
            Number B: <input type="" name="number_b">
            <button type="submit">OK</button>
        </form>
    </body>
</html>
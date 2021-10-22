defmodule Module1 do

  def fibonacci(n) do
    cond do
      n < 0 ->
        "valor no valido"
      n > 1 ->
        fibonacci(n - 1) + fibonacci (n - 2)
      n == 0 ->
        0
      n == 1 ->
        1
      end
  end

  def factorial(n) do
    cond do
    n < 0 ->
      "Valor no valido"
    n > 1 ->
      n * factorial(n - 1)
    n == 1 ->
      1
    n == 0 ->
      1
    end
  end

  def random_probability(n) do
    #Dado un número n, escoger un número aleatorio en el rango [1, n], digamos k
    #y determinar cuál es la probabilidad de que salga un número aleatorio
    #entre [k, n], el chiste obtener el número aleatorio.
    :ok
  end

  def digits(n) do
    :ok
  end

end

defmodule Module2 do

  def test () do
    fn (_) -> {:ok} end
  end

  def solve(a, b, n) do

    cont = 1
    uno =1

    Enum.each(1..n, fn(x)->
      #IO.puts x

      if a * x == n * cont + 1 do
        IO.puts "son primos" end

      cont = if a * x > n * cont do
       cont + 1 else cont + 1 end
       #IO.puts "Contador aumrento:"
       #IO.puts cont end

       if a * x != n * cont + 1 do
        IO.puts a * x
        IO.puts "no es igual a"
        IO.puts n * cont + 1 end

    end)

  end

end

defmodule Module3 do

  def rev(l) do
    :ok
  end

  def sieve_of_erathostenes(n) do
    :ok
  end

  def elim_dup(l) do
    [head | tail] = l
    IO.puts head
    contador = 0
    lista = []

    Enum.each(l, fn(x)->
      IO.puts "Elemento:"
      IO.puts x
      IO.puts "Tamaño lista: "
      IO.puts length(lista)
      if length(lista) == 1 do
      lista = lista ++ [x]
      end
      Enum.each(lista, fn(y)->
        if x != y do
          IO.puts x
          IO.puts "No es igual a: "
          IO.puts y
          contador = contador + 1
        else IO.puts "Elemento repetido" end
        end)

        if contador == length(lista)do
          [x |lista]
          contador = 0
        end

      end)

      lista
  end

end

defmodule Module4 do

  def monstructure() do
    :ok
  end

end

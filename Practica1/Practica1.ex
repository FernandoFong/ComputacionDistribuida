defmodule Module1 do
  @moduledoc """
  Module1: Funciones básicas.
  * Fibonacci
  * Factorial
  * Random
  * Digits
  """
  
  @doc """
  fibonacci: Implementación recursiva del n-esimo
  termino de la serie de fibonacci.
  
  fibonacci(0) = 0
  fibonacci(sucesor(0)) = sucesor(0)
  fibonacci(sucesor(sucesor(n))) = fibonacci(sucesor(n)) +
  fibonacci(n)
  """
  def fibonacci(0) do
    0
  end

  def fibonacci(1) do
    1
  end
  
  def fibonacci(n) do
    fibonacci(n-1)+fibonacci(n-2)
  end

  @doc """
  factorial: Implementación recursiva del factorial.
  
  factorial(0) = 1
  factorial(sucesor(n)) = sucesor(n)*factorial(n)
  """
  def factorial(0) do
    1
  end
  
  def factorial(n) do
    n*factorial(n-1)
  end

  @doc """
  random_probability: Dado [1, 2, ..., k, ..., n] para alguna numero natural 
  aleatorio k menor o igual a n, la función
  determina la probabilidad de elegir algún número x 
  tal que k <= x <= n.
  """
  def random_probability(n) do
    #Dado un número n, escoger un número aleatorio en el rango [1, n], digamos k
    #y determinar cuál es la probabilidad de que salga un número aleatorio
    #entre [k, n], el chiste obtener el número aleatorio.
    k = :rand.uniform(n)
    IO.puts("[#{k},..., #{n}]")
    (n-k+1)/n
  end

  @doc """
  digits: regresa los digitos de n a manera de lista.
  """
  def digits(n) do
    if(n<10) do
      [n]
    else
      getdigits(n, [])
    end
  end

  
  #getdigits: función auxiliar que concatena el ultimo digito
  #           de n en nums.
  defp getdigits(n, nums) do
    if(n < 10) do
      [n|nums]
    else
      digit = rem(n, 10)
      n |> div(10) |> getdigits([digit|nums])
    end
  end
end

defmodule Module2 do
  @moduledoc """
  Module2: 
  * test/0
  * solve/3
  """
  @doc """
  test/0 Crea una lambda y regresa :ok
  """
  def test() do
    fn ->  :ok end
  end
  
  @doc """
  solve/3: En caso de ser posible regresa la x tal que 
              a·x \congruente b mod n.
	   Si no devuelve :error
  """
  def solve(a, b, n) do
    # ax \congr b mod n -> ax -b = n * k para alguna k en N.
    # -> ax \congr b mod n <-> x = (n*k+b)/a and ax = n*k+b
    x = div(n+b, a)
    k = div(a*x-b, n)
    if(a*x-b == n*k) do
      x
    else
      :error
    end
  end
end

defmodule Module3 do
  @moduledoc """
  Module3:
  * rev/1, reversa de una lista.
  * sieve_of_erathostenes/1, primos primos hasta n.
  * elim_dup/1, elimina elementos duplicados.
  *
  """
  @doc """
  rev/1: devuelve la reversa de la lista.
  """
  def rev([]) do
    []
  end

  def rev([x|xs]) do
    rev(xs)++[x]
  end

  @doc """
  sieve_of_erathostenes/1: Regresa los primos 
  en el intervalo [0, n]
  """
  def sieve_of_erathostenes(n) do
    if(rem(n,2)==0) do
      m = div(n, 2)-1
      lista = Enum.to_list(1..m)
      |> Enum.map(fn x->2*x+1 end)
      actualiza_lista(lista, 0, n)
    else
      m = div(n, 2)
      lista = Enum.to_list(1..m)
      |> Enum.map(fn x->2*x+1 end)
      actualiza_lista(lista, 0, n)
    end
  end
  
  defp actualiza_lista(lista, i, n) do
    div = Enum.at(lista, i)
    if( div*div < n) do
      lista = Enum.reject(lista, fn x -> rem(x, div) == 0  end)
      [div|lista]
      |> actualiza_lista(i+1, n)
    else
      [2|lista]
    end
  end
  
  @doc """
  elim_dup/1: Elimina elementos duplicados en 
  la lista recibida, no borra la 
  primer instancia.
  """
  def elim_dup([]) do
    []
  end

  def elim_dup([x|xs]) do
    if(esta?(x, xs)==True) do
      elim_dup([x]++borra(x, xs))
    else
      [x]++elim_dup(xs)
    end
  end

  # esta?/2 : función auxiliar, indica si el primer
  #         elemento recibido está en la lista recibida.
  defp esta?(x, [y|ys]) do
    if(x == y) do
      True
    else
      esta?(x, ys)
    end
  end
  
  defp esta?(_, []) do
    False
  end

  # borra/2: Elimina las instancias de a en la lista
  #          recibida, las que no lo son las concatena 
  defp borra(a ,[x|xs]) do
    if(a==x) do
      xs
    else
      [x]++borra(a, xs)
    end
  end
  
end

defmodule Module4 do
  @moduledoc """
  Module4:
         * monstructure\0: Manejo de estructuras por paso de mensajes.
  """
  @doc """
  monstructure/0 inicializador
  """
  def monstructure() do
    spawn(fn -> monstructure([], {}, %{}, MapSet.new())end)
  end

  @doc """
  monstructure/4: Manejo de paso de mensajes
  """
  def monstructure(lista, tupla, map, ms) do
    receive do
      {:put_list, n} -> 
	if(Enum.count(lista) == 0) do
	  monstructure(lista++[n], tupla, map, ms)
	else
	  monstructure([lista|n], tupla, map, ms)
	end
	
	{:get_list_size, destino} -> send(destino, {:list_size, Enum.count(lista)})
      monstructure(lista, tupla, map, ms)

	{:rem_list, num} -> monstructure(rem_list(lista, num), tupla, map, ms)

	# tuplas
	{:get_tuple, destino} -> send(destino, {:tuple_get, tupla})
	  monstructure(lista, tupla, map, ms)
	
	{:tup_to_list, destino} -> send(destino, {:tuple_as_list, Tuple.to_list(tupla)})
	    monstructure(lista, tupla, map, ms)
	    
        {:put_tuple, num} -> monstructure(lista, Tuple.append(tupla,num), map, ms)

	#mapsets
	{:mapset_contains, num, destino} -> send(destino, {:contains_mapset,
							  MapSet.member?(ms, num)})
	monstructure(lista, tupla, map, ms)
		  
	{:mapset_add, num} -> monstructure(lista, tupla, map, MapSet.put(ms, num))

	{:mapset_size, destino} -> send(destino, {:size_mapset, MapSet.size(ms)})
	monstructure(lista, tupla, map, ms)

	#maps
	  {:map_put, llave, num} -> monstructure(lista, tupla, Map.put(map, llave, num), ms)

        {:map_get, llave, destino} -> send(destino, {:get_map, Map.get(map, llave)})
	monstructure(lista, tupla, map, ms)

	{:map_lambda, llave, f, y} ->
	 monstructure(lista, tupla, Map.put(map, llave, f.(Map.get(map, llave),y)), ms)
    end
  end

  #rem_lista: elimina num de lista
  defp rem_list(lista, num) do
    case lista do
      [] -> []
      [x|xs] when x == num -> xs
      [x|xs] -> [x|rem_list(xs, num)]
    end
  end
  
end

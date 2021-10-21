defmodule Module1 do

  @doc """
    Implementación de fibonacci. Para esta función se uso case, para saber
    cual saber que caso debe aplicar de la función recursiva. Esto por que
    necesitamos llegar a los casos base.

    (Se pudo implementar también con casa de patrones directo a las funcio-
    nes.)

    Adicionalmente checa que la entrada sea un número y que sea positivo.
  """
  def fibonacci(n) do
    case n do
      0 -> 0
      1 -> 1
      n ->
        if n > 1 && is_number(n) do
          fibonacci(n-1) + fibonacci(n-2)
        else
          IO.puts("La entrada #{inspect n} es inválida.")
          :error
        end
    end
  end

  @doc """
    El factorial de n, es el producto de los n números.

    Se implemento usando casa de patrones, donde según la entrada cazará con
    alguna de las definiciones para la función.

    Se definio el caso para 0 y para 1. Convencionalmente 1, es el caso base,
    pero si solo definimos este caso, quedaría indefinido el 0.

    Para el caso de n, hace la misma evaluación que en el caso anterior.
  """
  def factorial(0), do: 1
  def factorial(n) do
    if n > 0 && is_number(n) do
      n * factorial(n-1)
    else
      IO.puts("La entrada #{inspect n} es inválida.")
      :error
    end
  end

  @doc """
    Obtiene un número aleatorio entre el 1 y el n.

    Calcula cual es la probabilidad de cada uno de los números en ese rango
    prob_num. Entonces calcula cual es la probabilidad de aparición de todo
    el rango [k .. n].
  """
  def random_probability(n) do
    #Dado un número n, escoger un número aleatorio en el rango [1, n], digamos k
    #y determinar cuál es la probabilidad de que salga un número aleatorio
    #entre [k, n], el chiste obtener el número aleatorio.
    k = :rand.uniform(n)
    prob_num = 1 / n
    prob_k = (k * prob_num)
    "La probabilidad de que salga el valor k = #{inspect k} es de #{inspect prob_k}"
  end

  @doc """
    Va a separar los digitos del número.

    Primero, vérifica que la entrada sea un número.

    Luego, sí el número es negativo, va a añadir un atómico que represente
    el signo - y va a continuar su ejecución con el valor absoluto del nú-
    mero.

    Si el número ya es un digito, es decir n < 10. Devuelve la lista con
    ese dígito (Se tuvo que implementar la conversión, por que, al meter
    n a la lista, Elixir lo transformaba automáticamente a ASCII).

    Si el número aún no es un digito. Va a separar el último dígito del
    número (que va a caer en el caso base), y va a separar el resto del
    número. Así hará recursión sobre ambos,  concatenará la lista que
    obtenga de esta llamada.
  """
  def digits(n) do
    cond do
      ! is_number(n) ->
        IO.puts("#{inspect n} no es un número.")
        :error
      n < 0 ->
        [:-] ++ digits(abs(n))
      # Esto es para agregar un digito a la lista. Elixir, transformaba automáticamente el digito en un caracter códificado en Ascii.
      n < 10 ->
        n = Integer.to_string(n)
        n = Integer.parse(n)
        {var, _} = n
        [var]
      n ->
        digits(div(n,10)) ++ digits(rem(n,10))
    end
  end

end

defmodule Module2 do

  @doc """
    Función test.
  """
  def test do
    fn x -> x end
    :ok
  end

  @doc """
    Función auxiliar que calcula el MCD mediante una implementación del Al-
    goritmo de Euclides.
  """
  defp mcd(x,y) do
    case y do
      0 -> x
      y -> mcd(y,rem(x,y))
    end
  end

  @doc """
    La forma en la que podemos saber si la ecuación a x ~= b mod n. Es caculando el mcd de a y n, si
    este es 1, significa que a y n son primos relativos y por lo tanto tienen solución. En otro caso
    significa que no son primos relativos y que la ecuación no tiene solución.

    Para esto, se usará la función auxiliar.

    (~= representa el símbolo de congruencia).
  """
  def solve(a,b,n) do
    if mcd(a,n) == 1 do
      "La ecuación #{inspect a} x ~= #{inspect b} mod #{inspect n} tiene solución."
    else
      "La ecuación #{inspect a} x ~= #{inspect b} mod #{inspect n} no tiene solcuión."
    end
  end
end

defmodule Module3 do

  @doc """
    Función que devuelve la reversa de una lista.

    Si la lista es vacía devuelve la lista vacía.

    En otro caso, concatena la lista con el elemento en la cabeza, con la lla-
    mada recursiva a la función sobre la cola.
  """
  def rev([]), do: []
  def rev([x | xs]) do
    rev(xs) ++ [x]
  end

  @doc """
    Función que busca exhaustivamente si el elemento x se encuentra dentro
    de la lista [y|ys].
  """
  defp is_rep(_,[]), do: false
  defp is_rep(x,[y | ys]) do
    if x == y do
      true
    else
      is_rep(x,ys)
    end
  end

  @doc """
    Generá una lista auxiliar sin repeticiones. Para esto busca si el
    elemento no ha sido ya añadido a la lista auxiliar.

    Si el elemento no ha sido explorado, lo agrega a la lista y sigue
    buscando sobre la lista original. Los elementos que descubra que
    ya ha revisado, los va a ignorar.
  """
  defp sin_rep([],l), do: l
  defp sin_rep([x|xs],l) do
    if is_rep(x,l) do
      sin_rep(xs,l)
    else
      sin_rep(xs, l ++ [x])
    end
  end

  @doc """
    Para la implementación se va a recurrir a crear una lista auxiliar
    (que inicializa en vacía), donde va a agregar los elementos que no
    hayan aparecido en la lista original.
  """
  def elim_dup(l) do
    l = sin_rep(l, [])
  end

  @doc """
    Para generar los números primos de 2 a n. Vamos a verificar, que la entrada
    sea un número mayor que 2.

    En caso de ser afirmativo, construye una lista, apartir del rango de 2 a n.

    Y manda llamar a la función auxiliar sieve_of_erathostenes_recursive, que
    va a resolver el problema.
  """
  def sieve_of_erathostenes(n) do
    if n < 2 && is_number(n) do
      "La entrada es inválida."
    else
      rango = 2 .. n
      nums = Enum.to_list(rango)
      sieve_of_erathostenes_recursive(nums)
    end
  end

  @doc """
    Esta función es destructiva, significa que va a modificar la estructura de
    datos que recibe como entrada (en este caso una lista). Se podría plantear
    una función, que reciba la lista original y construya una lista nueva. Sin
    embargo, por razones de optimización de memoria, y como estamos trabajando
    en paradigma funcional, se opto por esta alternativa.

    Lo que va a hacer esta función es tomar el primer elemento de la lista x, y
    va a eliminar de esta, todos aquellos elementos y, tales que mod x y = 0.
    Es decir, todos aquellos elementos que son múltiplos de x. Por definición
    un número primo, solo es múltiplo de sí mismo y 1. Por lo que, estamos
    quitando todos los números compuestos de la lista.

    Este proceso, lo va a hacer recursivamente, añadiendo el elemento x al ini-
    cio de la lista, hasta, llegar a la lista vacía.
  """
  defp sieve_of_erathostenes_recursive([]), do: []
  defp sieve_of_erathostenes_recursive([x | xs]) do
    xs = Enum.filter(xs, fn y -> rem(y,x) != 0 end)
    [x] ++ sieve_of_erathostenes_recursive(xs)
  end

end

defmodule Module4 do

  @doc """
    Crea un proceso, llamado server que va a inicializar todas las estructuras
    de datos. Va a guardar el ID de este proceso, ya que va a ser elemental pa-
    ra establecer un canal de comunicación con el proceso que resuelve las es-
    tructuras.

    Este proceso principal, solo va a mandar mensajes al servidor, luego,
    abrirá y consumirá su buzón con la función auxiliar, buzon/1.
  """
  def monstructure() do
    # En este caso se implemento una función recursiva que mantiene
    # al canal ecuchando, por eso en cada llamada, debe de mandar las
    # estrcutrudas de datos.

    # Ninguna operación agrega elementos a la tupla, por lo que para el
    # ejemplo, esta no se inicializa en vacío.
    pid = spawn(fn -> server([], {:a, 2, "a", 3, :b}, Map.new, MapSet.new, true) end)

    # Secuencias de ejemplos para cada estructura.
    #ejemplos_listas(pid)
    #ejemplos_tuplas(pid)
    #ejemplos_diccionarios(pid)
    ejemplos_conjuntos(pid)

    # Llama al buzón.
    buzon(true)
  end

  @doc """
    Función con una secuencia de uso para listas en esta monstruo estrcutura.
  """
  defp ejemplos_listas(pid) do
    # Ejemplos de peticiones a listas.
    send(pid, {:add, :list, self(), 1})
    send(pid, {:add, :list, self(), 2})
    send(pid, {:add, :list, self(), 3})
    send(pid, {:add, :list, self(), 4})
    send(pid, {:add, :list, self(), 5})
    send(pid, {:length, :list, self()})
    send(pid, {:delete, :list, self(), 3})
    send(pid, {:length, :list, self()})
    send(pid, {:add, :list, self(), 6})
    send(pid, {:add, :list, self(), 7})
    send(pid, {:length, :list, self()})
    # Estas dos no son reconocidas por el servidor.
    send(pid, {:concat, :list, self(), [1,2,3]})
    send(pid, {:size, :list, self()})
  end

  @doc """
    Función con una secuencia de uso para tuplas en esta monstruo estrcutura.
  """
  defp ejemplos_tuplas(pid) do
    # Ejemplos de peticiones a tuplas.
    send(pid, {:get, :tuple, self()})
    send(pid, {:set, :tuple, self(), :c, 0})
    send(pid, {:set, :tuple, self(), 1, 1})
    send(pid, {:set, :tuple, self(), "b", 2})
    send(pid, {:set, :tuple, self(), :d, 4})
    send(pid, {:get, :tuple, self()})
    send(pid, {:to_list, :tuple, self()})
    # Estas dos no son reconocidas por el servidor.
    send(pid, {:equal, :tuple, self(), {1,2,3,:a,"b"}})
    send(pid, {:firs_elem, :tuple, self()})
  end

  @doc """
    Función con una secuencia de uso para diccionarios en esta monstruo estrcutura.
  """
  defp ejemplos_diccionarios(pid) do
    # Ejemplos de peticiones a diccionarios.
    send(pid, {:put, :map, self(), :a, 1})
    send(pid, {:put, :map, self(), :b, 2})
    send(pid, {:put, :map, self(), :c, 3})
    send(pid, {:get_value, :map, self(), :a})
    send(pid, {:get_value, :map, self(), :b})
    send(pid, {:get_value, :map, self(), :d})
    send(pid, {:eval_lamb, :map, self(), :a, fn x, y -> x + y end, 5})
    send(pid, {:eval_lamb, :map, self(), :b, fn x, y -> x * y end, 10})
    # Estas dos no son reconocidas por el servidor.
    send(pid, {:get_key, :map, self(), 2})
    send(pid, {:set_elements, :map, self(), {:b, 1}})
  end

  @doc """
    Función con una secuencia de uso para conjuntos en esta monstruo estrcutura.
  """
  defp ejemplos_conjuntos(pid) do
    # Ejemplo de peticiones a conjuntos.
    send(pid, {:put, :map_set, self(), 1})
    send(pid, {:put, :map_set, self(), 2})
    send(pid, {:put, :map_set, self(), 3})
    send(pid, {:put, :map_set, self(), 4})
    send(pid, {:size, :map_set, self()})
    send(pid, {:put, :map_set, self(), 5})
    send(pid, {:put, :map_set, self(), 6})
    send(pid, {:put, :map_set, self(), 1})
    send(pid, {:size, :map_set, self()})
    send(pid, {:in, :map_set, self(), 1})
    send(pid, {:in, :map_set, self(), 10})
    # Estas dos no son reconocidas por el servidor.
    send(pid, {:union, :map_set, self(), MapSet.new([10,11,12])})
    send(pid, {:elemnts, :map_set, self()})
  end

  @doc """
    Función que va a leer el buzón de entrada del proceso principal, hasta
    que deje de recibir mensajes. Cuando su buzón este vació reportará que
    ha terminado de leer.

    Para detectar cuando no hay más mensajes se usa un tiempo de espera de
    1 segundo, y cambia la bandera que recibe la función.
  """
  defp buzon(bandera) do
    if bandera do
      receive do
        # Listas.
        {:ok, :delete, :list, elem} ->
          IO.puts("Se elimino correctamente #{inspect elem} de la lista.")
          buzon(true)
        {:ok, :add, :list, elem} ->
          IO.puts("Se agrego #{inspect elem} a la lista.")
          buzon(true)
        {:ok, :length, :list, length} ->
          IO.puts("El tamaño de la lista es #{inspect length}.")
          buzon(true)

          # Tuplas.
        {:ok, :get, :tuple, tuple} ->
          IO.puts("La tupla es #{inspect tuple}")
          buzon(true)
        {:ok, :set, :tuple, value, pos} ->
          IO.puts("Se modifico el valor de la tupla en la posición #{inspect pos}, ahora es #{inspect value}")
          buzon(true)
        {:ok, :to_list, :tuple, list} ->
          IO.puts("La tupla como lista es #{inspect list}.")
          buzon(true)

          # Diccionarios
        {:ok, :put, :map, key, value} ->
          IO.puts("Se agrego al diccionario el valor #{inspect value} con la llave #{inspect key}.")
          buzon(true)
        {:ok, :get_value, :map, key, value} ->
          IO.puts("El elemento con la llave #{inspect key}, es #{inspect value}.")
          buzon(true)
        {:ok, :eval_lamb, :map, op1, op2, value} ->
          IO.puts("El resultado de evaluar la función con #{inspect op1} y #{inspect op2} es #{inspect value}.")
          buzon(true)

        # Conjuntos
        {:ok, :in, :map_set, elem, bool} ->
          if bool do
            IO.puts("El elemento #{inspect elem}, pertenece al conjunto.")
          else
            IO.puts("El elemento #{inspect elem}, no pertenece al conjunto.")
          end
          buzon(true)
        {:ok, :size, :map_set, size} ->
          IO.puts("El tamaño del conjunto es #{inspect size}.")
          buzon(true)
        {:ok, :put, :map_set, elem} ->
          IO.puts("Se agrego #{inspect elem} al conjunto.")
          buzon(true)

        # En caso de que la petición sea inválida, devuelve un atómico que
        # informa del error, el operador que es inválido y la estructura
        # para la que el operador es inválido.
        {:error, :op_invalida, op, estruct} ->
          IO.puts("#{inspect :op_error}: No sé reconoce el operador #{inspect op} para #{inspect estruct}")
          buzon(true)
        {:error, :not_found, estruct} ->
          IO.puts("#{inspect :not_found_error}: El valor introducido no ha sido encontrado en #{inspect estruct}")
          buzon(true)
      after
        1_000 ->
          "Se rebaso el tiempo de espera."
          buzon(false)
      end
    else
      "Nada más en el buzón."
    end
  end

  @doc """
    Va a iniciar un servidor donde va a ir recibiendo las estructuras de
    datos. Esta implementación originalmente contenia las propias estruc-
    turas. Sin embargo la extensión de funcionalidad, para que el servi-
    dor se mantuviera escuchando, demandaba que las estructuras fuera re-
    cibidas en cada llamada recursiva.

    En cuanto al paso de mensajes, el formato de entrada es:

    {:petición, :estructura, remitente, ...}

    La :petición será un atómico que describa la operación que quiere
    que se realice sobre la estructura de datos, En general estas son:

      : get -> devuelve un elemento o subestructura.
      : set -> modifica la estrcutura.
      : length / : size -> devuelve el tamaño de la estructura.
      : delete -> elimina un elemento o una subestrcutrua.

    Hay múltiples casos partículares, pero se espera que se sobreen-
    tiendan con el nombre de los atómicos.

    La :estructura, será aquella sobre la que se quiere operar, y
    pueden ser:

      :list -> lista de elementos.
      :tuple -> tupla.
      :map -> diccionario.
      :map_set -> conjunto.

      Cada estructura es tratada según las partícularidades de la
      misma.

      Remitente hace referencia al proceso que envia el mensaje,
      esto con el propósito de poder contestar a dicho mensaje, con
      la información solicitada

      Finalmente se incluye una serie de paramétros que pueden ser
      desde 0 a n, según los requerimientos de la operación. Por
      ejemplo: :lenght para listas no necesita ningún paramétro,
      mientras que :delete para esta misma estructura, necesita de
      el elemento que necesita eliminar.

      Mientras que los mensajes de contestación, se comportan de ma-
      nera similar. Existen principalmente dos tipos:

        :ok -> cuando la operación se pudo realizar correctamente.
        :error -> cuando algo impidio que se completara la opera-
        ción

      En el caso de los mensajes satisfactorios, se va a devolver
      además, la solicitud que se hizo al servidor, el tipo de
      estructura sobre la que se opero y siempre algún paramétro
      adicional. Ya sea la entrada, para informar del éxito de la
      operación al usuarix, o el resultado en caso de que sea par-
      te de la solicitud, por ejemplo, en los gets.

      Así, el servidor estará leyendo todo su buzón, una vez que no
      se encuentren mensajes y después de 1 segundo de espera, se
      desactiva la bandera del servidor y con esto. Se cierra la
      comunicación.
  """
  defp server(l, t, m, ms, bandera) do
    if bandera do
      receive do
        # Borra un elemento de la lista.
        {:delete, :list, rem, elem} ->
          l = List.delete(l, elem)
          # Se uso para vérificar que hubiera eliminado los elementos de la lista.
          # Enum.each(l, fn x -> IO.puts(x) end)
          send(rem, {:ok, :delete, :list, elem})
          server(l, t, m, ms, true)

        # Añade un elemento a la lista.
        {:add, :list, rem, elem} ->
          l = l ++ [elem]
          # Se uso para vérificar que hubiera eliminado los elementos de la lista.
          # Enum.each(l, fn x -> IO.puts(x) end)
          send(rem, {:ok, :add, :list, elem})
          server(l, t, m, ms, true)

        # Devuelve el tamaño de la lista
        {:length, :list, rem} ->
          length = length(l)
          send(rem, {:ok, :length, :list, length})
          server(l, t, m, ms, true)

        # Se ponen clausulas en caso de que el operador sea incorrecto.
        {op, :list, rem} ->
          send(rem, {:error, :op_invalida, op, :list})
          server(l, t, m, ms, true)

        {op, :list, rem, _} ->
          send(rem, {:error, :op_invalida, op, :list})
          server(l, t, m, ms, true)


        # Devuelve la tupla.
        {:get, :tuple, rem} ->
          send(rem, {:ok, :get, :tuple, t})
          server(l, t, m, ms, true)

        # Actualiza el valor i de la tupla.
        {:set, :tuple, rem, value, i} ->
          t = Tuple.delete_at(t, i)
          t = Tuple.insert_at(t, i, value)
          send(rem, {:ok, :set, :tuple, value, i})
          server(l, t, m, ms, true)

        # Devuelve la tupla como una lista.
        {:to_list, :tuple, rem} ->
          t_list = Tuple.to_list(t)
          send(rem, {:ok, :to_list, :tuple, t_list})
          server(l, t, m, ms, true)

        # Se ponen clausulas en caso de que el operador sea incorrecto.
        {op, :tuple, rem} ->
          send(rem, {:error, :op_invalida, op, :tuple})
          server(l, t, m, ms, true)

        {op, :tuple, rem, _} ->
          send(rem, {:error, :op_invalida, op, :tuple})
          server(l, t, m, ms, true)


        # Se agrega un elemento con su llave al diccionario.
        {:put, :map, rem, key, value} ->
          m = Map.put(m, key, value)
          send(rem, {:ok, :put, :map, key, value})
          server(l, t, m, ms, true)

        # Devuelve el valor de la llave indicada.
        {:get_value, :map, rem, key} ->
          value = Map.get(m, key)
          # Verifica si el valor existe.
          if value != nil do
            send(rem, {:ok, :get_value, :map, key, value})
          else
            send(rem, {:error, :not_found, :map})
          end
          server(l, t, m, ms, true)

        # Evalua la función lambda con el operador introducido y el obtenido
        # de la llave marcada.
        {:eval_lamb, :map, rem, key, fun, op} ->
          value = Map.get(m, key)
          res = fun.(value,op)
          send(rem, {:ok, :eval_lamb, :map, value, op, res})
          server(l, t, m, ms, true)

        # Se ponen clausulas en caso de que el operador sea incorrecto.
        {op, :map, rem} ->
          send(rem, {:error, :op_invalida, op, :map})
          server(l, t, m, ms, true)

        {op, :map, rem, _} ->
          send(rem, {:error, :op_invalida, op, :map})
          server(l, t, m, ms, true)


        # Verifica que el elemento este en el conjunto.
        {:in, :map_set, rem, elem} ->
          bool = MapSet.member?(ms, elem)
          send(rem, {:ok, :in, :map_set, elem, bool})
          server(l, t, m, ms, true)

        # Devuelve el tamaño del conjunto.
        {:size, :map_set, rem} ->
          m_list = MapSet.to_list(ms)
          size = length(m_list)
          send(rem,{:ok, :size, :map_set, size})
          server(l, t, m, ms, true)

        # Agrega un elmento al conjunto.
        {:put, :map_set, rem, elem} ->
          ms = MapSet.put(ms, elem)
          send(rem, {:ok, :put, :map_set, elem})
          server(l, t, m, ms, true)

        # Se ponen clausulas en caso de que el operador sea incorrecto.
        {op, :map_set, rem} ->
          send(rem, {:error, :op_invalida, op, :map_set})
          server(l, t, m, ms, true)

        {op, :map_set, rem, _} ->
          send(rem, {:error, :op_invalida, op, :map_set})
          server(l, t, m, ms, true)
      after
        1_000 ->
          server(l, t, m, ms, false)
      end
    else
      IO.puts("Buzón del servidor completamente leído.")
    end
  end

end

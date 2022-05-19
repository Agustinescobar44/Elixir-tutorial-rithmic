defmodule Todos do
  @nombre_archivo "tareas"

  def crearTareas() do
    {cantTareas,_}=
      IO.gets("Ingrese cantidad de tareas a agregar: ")
        |> Integer.parse()
    for _i <- 1..cantTareas do
      IO.gets("Ingrese la tarea: ") |> String.trim() |> String.capitalize()
    end
  end

  def agregarTarea(tareas, tarea) do
    if !contents?(tareas, tarea) do
      List.insert_at(tareas, Enum.count(tareas)-1, tarea)
    else
      tareas
    end
  end

  def completarTarea(tareas,tarea) do
    if contents?(tareas,tarea) do
      List.delete(tareas,tarea)
    else
      :tarea_no_encontrada
    end
  end

  def contents?(tareas,tarea) do
    Enum.member?(tareas,tarea)
  end

  def dameTareaAleatoria(tareas) do
    [ret] = Enum.take_random(tareas,1)
    ret
  end

  def encontrarTarea(tareas, palabra) do
    for tarea <- tareas, String.contains?(tarea, palabra), do: tarea
  end

  def guardar(tareas) do
    binario = :erlang.term_to_binary(tareas)
    case File.write(@nombre_archivo, binario) do
      :ok ->
        "Guardado exitoso"
      {:error, _razon} ->
        "Error al guardar"
    end
  end

  def leer do
    {result, binarios} = File.read(@nombre_archivo)
    case result do
      :ok -> :erlang.binary_to_term(binarios)
      :error -> "el archivo no existe"
    end

  end

end

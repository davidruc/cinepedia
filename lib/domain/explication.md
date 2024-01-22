Esta carpeta "domain" va a contener las reglas de juego de la aplicación y también el tipo o la entidad que voy a utilizar a lo largo de la aplicación. No me importa el dominio, ni el tipo de dato. Mi aplicación va a trabajar con mi entidad


* Entidad: En la entidad tengo un objeto en donde están todos datos y su tipo de dato que voy a recibir. Yo no voy a usar directamente los datos de mi API porque puede generar problemas.

* Datasources: Se usa para definir como quiero que sean mis orígenes de datos. Y normalmente quiero que sea abstracta ya que no quiero generar instancias de esa clase. Va a llamar los méotods que voy a tener definidos para llamar la data. Por ejemplo, sé que voy a definir un método que es "getNowPlaying()". No lo voy a implementar, pero es una especie de definición. En algún momento lo voy a utiliza

```dart
Future<List<Movie>> getNowPlaying({ int page = 1 });
```

* Repositories: Los repositorios suelen ser iguales a las datasource, pero, los repositorios son los que van a llamar al dataSource. No llamamos de manera directa el datasource, porque el repositorio es el que me va a permitir cambiar el datasource, puedo ir cambiar el origen de datos sin prácticamente ningun cambio.
# cinepedia

1. copiar el .env.example y renombrarlo a .env
2. Configurar las variables de entorno (The Moviedb)


Es importante David del futuro que sepas que flutter no maneja los archivos de variables de entorno .env por defecto.
Por lo que es necesario instalar un archivo de terceros como dotenv. https://pub.dev/packages/flutter_dotenv y después realizar la configuración en el pubspect.yaml.

en el main.dart se utiliza siguiendo la documentación.

Para usarlas es simplemente así 

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
env['VAR_NAME'];
```

El echo de estar usando así nuestras variables de entorno es poco práctico, porque un espacio o cualquier cosa mal ya será un error fatal. Por lo que es buena practica crear un archivo en config que se llame constants, y dentro podemos crear un archivo llamado enviroment.dart.

```

```

Tendrá una clase con las variables de entorno estáticas para que sean fáciles de utilizar.


3. Cambios en la entidad, ejecutar : 

```hash
flutter pub run build_runner build
```
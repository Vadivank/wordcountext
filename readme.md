# Программа подсчета слов в тексте


## Документация
- [Техническое задание](specification/specification.md)


## Тестовый текст
Приложение испытывалось на произведении _Л.Н.Толстого "Война и мир"_. Экземпляр текста размещен в папке проекта `text`

## Развертывание приложения
- _Pre-build_: 
    ```
    cmake -B <build_directory> -G <your_generator>
    ```

- _Сборка приложения_: 
    ```
    cmake --build <build_directory>
    ```

- _Установка (with Windows needs to specify the path to QT in CMakeLists.txt)_: 
    ```
    cmake --build <build_directory> --config release --target install
    ```
В папке сборки проекта `<build_directory>` будет создана папка `wcountext-win` (если сборка осуществлялась в Windows) и `wcountext-linux` (для Linux). Данная папка и будет представлять собой готовое для использования/переноса приложение. При развертывании нового релиза (без использования CI/CD) необходимо указанную папку `wcountext-win` или `wcountext-linux` сохранить в архив и перенести в папку `releases`.

- _Генерация сборки документации (Doxygen installed requirements)_: 
    ```
    cmake --build <build_directory> --target doxygen
    ```
Докмуентация по проекту, сгенерированная Doxygen (располагается в папке сборки `<build_directory>/dochtml`) является неотъемлемой частью проект и обновляется при указании целевой задачи для `CMake` командой `doxygen`.


## Инструменты разработки

Для разработки кода и написания документации использовались следующие инструменты:
- [MinGW-w64](https://www.mingw-w64.org/)
- [VSCode](https://code.visualstudio.com/)
- [CMake](https://cmake.org/download/)
- [Ninja](https://github.com/ninja-build/ninja/releases)
- [Qt5.12.12](https://www.qt.io/)
- [Doxygen](https://github.com/doxygen/doxygen/releases)

## Допущения
При компиялции необходимо отключать оптимизацию компилятора, флаг `O0`, поскольку в потоке есть бесконечный пустой цикл (постановка треда на паузу - да, это некашерно, но нужно было быстрое решение), и компилятор изменит его так, что зайти в этот цикл будет возможно, а выйти - нет. В этой связи, если убрать в верхнеуровневом __CMakeLists.txt__ строку `set(CMAKE_CXX_FLAGS_RELEASE "-O0")`, то приложение будет работать некорректно в IDE, которые автоматически включают оптимизацию компилтяора.

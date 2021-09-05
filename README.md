# Кросскомпилятор на основе buildroot

## Сборка
Параметры сборки:

`BUILDROOT_DEFCONFIG` - один из предустановленных конфигов buildroot

`NPROC` - количество работ выполняемых параллельно во время сборки (`make -j $NPROC`)

Пример:
```
docker build -t crosscompiler:arm --build-arg NPROC=4 --build-arg BUILDROOT_DEFCONFIG=qemu_arm_versatile_defconfig .
```
## Запуск
Для сборки кода и получения собранных бинарников необходимо пробросить исходники в образ при помощи docker volumes (-v), после чего указать необходимые флаги компилятора после имени образа

Пример:
```
docker run -v $PWD/src/:/src -v $PWD/result:/result/ crosscompiler:arm -static -o /result/hello-arm /src/hello.cpp && qemu-arm result/hello-arm
```


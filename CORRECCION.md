### General

- [-1] El script no ejecuta tal como está

### pipeline.sh

- [-1] Algunos comandos parecen esperar estar situados fuera del working directory
  (e.g. decont/data/urls) y otros dentro (scripts/download.sh), causando uno de
  los dos grupos falle dependiendo del modo de ejecución.
- [-1] Las rutas a los ficheros de datos son absolutas, con lo cual el script
  sólo puede ejecutarse en esa máquina en la cuenta de ese usuario particular.
  Deberían ser relativas
  (`/home/vant/decont/out/trimmed/C57BL_6NJ_1s.trimmed.fastq.gz ->
  out/trimmed/C57BL_6NJ_1s.trimmed.fastq.gz`)
- [-0.5] L4: nombre de variable incorrecto (`$urls -> $url`)
- [-0.5] L15: el comando de generación de sample ids devuelve el nombre
  completo de los archivos
- [-0.5] L20,28: faltan los encabezados de los for
- [-0.5] L20,28: se usa un for por muestra en lugar de uno único genérico
- [-0.5] L69,70: caracteres `>` al final de las líneas
- [-1] L64-70: cat realizado sobre un directorio

### download.sh

- [-1] Falta el comando para descargar archivos
- [-0.5] L4,5: Mas variables están mal definidas (espacios antes y después del "=")
- [-0.5] L10: faltan espacios después y antes de los corchetes
- [-0.5] L12: Falta el `$` en la variable
- [-0.5] L16: Falta el `fi` para finalizar el `if`

### index.sh

- [-0.5] El parámetro `--runMode` debería ser "genomeGenerate"

### merge.sh

- [-1] El script recibe el ID de cada muestra, pero el código ejecuta ambas
  simultáneamente.
- [-1] Los nombres de los archivos están fijos, deberían construirse con los
  parámetros y utilizar wildcards.

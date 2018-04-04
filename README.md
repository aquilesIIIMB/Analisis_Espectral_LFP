# Assessing of Non-invasive Spinal Cord Stimulation Effectivity by Means of PSD and Coherence Analysis  

Archivos principales
- **main.m:** Analiza los canales del registros .continuous, configurando los parametros iniciales y escogiendo que tipo de analisis se hara, Espectral y Coherencia. 
  Los parametros son,
  * path: Es la ruta donde esta la carpeta de los archivos .continuous pertenecientes al registro que se quiere analizar.
  ```matlab
  Ej: %%% Windows
      path = 'D:\Descargas\Trabajo de titulo\Database\+2500_300Hz\arturo_2017-06-09_15-24-39\'; 
      %%% Ubuntu
      path = '/home/cmanalisis/Aquiles/Registros/Database/-375/arturo_2017-05-30_15-46-44/';
  ```
  * timeRanges: Rangos de tiempo de cada etapa en minutos.
  ```matlab
  Ej: % Protocols DC or AC
      timeRanges = [5, 5, 5]; 
      % Protocols Mixtos
      timeRanges = [6, 6, 6]; 
  ```
  * threshold_amplitudes: Amplitud del umbral para remover artefactos.
  ```matlab
  Ej: % Threshold for 3 stages
      threshold_amplitudes = [15, 10, 10]; 
  ```
  * eval_channels: Numero de los canales que se analizaran.
  ```matlab
  Ej:  % Analysis from channel 14 to channel 21 and from channel 46 to channel 53
      eval_channels = [14:21,46:53];
      % Analysis from channel 1 to channel 64
      eval_channels = 1:64;
  ```
  * channel_codes: Codigo de cada canal, que indica al area del cerebro que pertenece.
  ```matlab
  Ej: % Flo Futbolistas UC coding
      channel_codes = 'channel-codes/channel_codes_florencia_PUC.csv'; 
  ```
    Las funciones dentro de main.m son,
    1. Initialization: 
      - Inicializa la estrucutura donde se guardarn los datos pre-procesados y procesados tanto en el tiempo, espectrales y coherencia (registroLFP). 
      - Muestra los parametros asignados antes, para verificar que estan correctos.
      - Si esta presente el archivo ADC8.continuous, entonces determina los triggers recibidos desde el estimulador, calculando el momento exacto del inicio de la estimulacion y su frecuencia.

    2. Extract_LFP: 
    - Carga los datos desde los archivos .continuous usando la libreria de OpenEphys (analysis-tools).
    - Realiza un filtro pasa bajo (fc=150Hz) para evitar el aliasing y para obtener el LFP de la señal.
    - Se hace un Downsampling para bajar de 30kHz a 1kHz.
    - Se realiza un filtro pasa alto (fc=0.1Hz) para eliminar lo mas posible la componente continua y los artefactos de bajas frecuencias.
    - Se recorta la señal para que dure exactamente lo que se espera del protocolo, eliminando los datos sobrantes al inicio y final de cada canal.
    - Se determina cuales son los indices de los posibles artefactos en cada canal y se realiza un zscore, sin tomar encuenta los valores de los artefactos para calcular el promedio y la desviacion estandar.
    - Finalmente se almacena cada canal pre-procesado (registroLFP.channels.data_raw)

    3. View_LFP_Raw_Ref: 

    4. Spectral_Channel_MT

    5. View_Spectrum_Channel_Area_IRASA

    6. Delete_CH

    7. Referencing

    8. View_LFP_Raw_Ref

    9. Spectral_Area_IRASA

    10. View_Spectrum_Channel_Area_IRASA

    11. Coherence_Area_MT

    12. View_Coherence_Area_MT

    13. Record_Masurements_IRASA

    14. sonido_alarma
    
- **Record_Masurements_IRASA.m:** 
  
- **PowerRanking_Protocols.m:** Realiza una tabla que permitira hacer un ranking de los registros que hayan sido cargados. El ranking se hace sobre las Oscilaciones en banda [8, 30] Hz, Fractales en banda [8, 30] Hz, ambas en potencia y normalizadas, y Fractales en todo el espectro [0, 100] Hz
- **PowerRanking_Total.m:** Realiza una tabla con el ranking por protocolos, usando el promedio de los registros de cada protocolo.










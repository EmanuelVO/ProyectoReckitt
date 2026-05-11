# ProyectoReckitt

Cada paso fue desarrollado en un entregable.

Las tablas de ventas proporcionadas son: 'DIM_CALENDAR (2).xlsx', 'DIM_CATEGORY (2).csv', 'DIM_PRODUCT (1).xlsx', 'DIM_SEGMENT (1).xlsx', 'FACT_SALES (1).csv'.

Relevancia del Análisis: 
- Revela tendencias y patrones en los datos
- Identifica los principales productos que están ganando o perdiendo margen de mercado
- Obtiene un pronóstico de ventas
- Incluye visualizaciones de los datos para entender mejor su distribución y las relaciones entre diferentes variables
- Resume los hallazgos clave y proporciona recomendaciones estratégicas

Herramientas Utilizadas: Python(Jupyter Notebook), Orange, SQL y PowerBI

Pasos:
1. Carga y Limpieza de Datos: los datos fueron cargados en Pandas desde archivos CSV y Excel. Se realizó una limpieza exhaustiva para manejar valores nulos, eliminar duplicados y corregir inconsistencias en los datos.

2. Análisis Exploratorio de Datos (EDA) y Visualizaciones
<img width="1180" height="575" alt="image" src="https://github.com/user-attachments/assets/b20fb844-98be-4d11-b8a0-6645ed313bd6" />

<img width="1718" height="769" alt="image" src="https://github.com/user-attachments/assets/f9cfacc0-3287-48ba-9741-254c9cc8c308" />

<img width="1720" height="1035" alt="image" src="https://github.com/user-attachments/assets/6bea5ac9-5333-41ea-80e8-13c299c4609a" />

<img width="1028" height="665" alt="image" src="https://github.com/user-attachments/assets/b38a88cf-6e1e-4764-90f8-a8c6bc1562b2" />

<img width="1206" height="707" alt="image" src="https://github.com/user-attachments/assets/dfe6ee54-75fe-43c5-9895-915caa96915d" />

<img width="1424" height="707" alt="image" src="https://github.com/user-attachments/assets/f786a35d-30ad-44f1-b975-ecc1cd321ada" />

<img width="1352" height="911" alt="image" src="https://github.com/user-attachments/assets/2df2a938-67f7-45c4-8264-aed2b612226d" />

3. Aplicación de Clustering con K-Means: se aplicó el algoritmo K-Means para segmentar los productos o regiones en función de características clave como ventas totales, categorías y regiones.
<img width="1014" height="1033" alt="image" src="https://github.com/user-attachments/assets/7bb12b8b-a60e-4e8e-936f-f2c0329509c7" />

4. Creación de la Base de Datos: La base de datos fue diseñada e implementada en SQL Server utilizando las tablas de ventas proporcionadas

5. Creación de un Dashboard en PowerBI
<img width="1988" height="1125" alt="image" src="https://github.com/user-attachments/assets/5777e08a-4015-4e8d-af0e-e6e19904edf7" />

<img width="1998" height="1125" alt="image" src="https://github.com/user-attachments/assets/93d3d25b-2304-4bba-a480-0f9f4e0e59d8" />

<img width="1994" height="1125" alt="image" src="https://github.com/user-attachments/assets/cedc02a4-0f0b-410d-85d4-df46e873b476" />

6. Predicción de Ventas con Machine Learning: se utilizó un modelo de series de tiempo ARIMA para predecir las ventas futuras.
<img width="1718" height="529" alt="image" src="https://github.com/user-attachments/assets/334b931e-7c20-4c63-8002-b25cb2065594" />

7. Conclusiones y Recomendaciones
- La compañía debería priorizar el segmento BLEACH, ya que muestra mayor rentabilidad por unidad, lo que sugiere una oportunidad para maximizar utilidades enfocando inversión y expansión en este segmento. 
- En cuanto a marcas, se identifica una estrategia dual: CLORALEX debe mantenerse como motor de volumen y penetración de mercado, mientras que BLANCATEL puede posicionarse como una opción más rentable o premium, permitiendo equilibrar crecimiento y margen. 
- La evidencia de estacionalidad (picos en enero y caídas en julio) permite optimizar inventarios, producción y campañas, anticipando la demanda y reforzando ventas en periodos bajos.
- Finalmente, el liderazgo consistente de ciertas regiones sugiere la oportunidad de replicar prácticas exitosas en otras zonas, impulsando un crecimiento más equilibrado.

# Cómo usé IA en este proyecto

## Metodología

1. **PRD primero**: Escribí toda la arquitectura antes de generar código
2. **Trabajo por fases**: Estructura → Core → Features → UI → Testing
3. **Validación constante**: Compilé y probé cada archivo generado
4. **Gestión de límites de Claude**: Inicié el desarrollo cuando quedaban aproximadamente 80 minutos para que se restableciera el límite de 5 horas, asegurando tiempo suficiente para completar el proyecto

## División del trabajo

- **Arquitectura y decisiones**: 100% yo (Clean Architecture, Riverpod, sin Freezed)
- **Código estructural**: 70% Claude (providers, repositories, boilerplate)
- **Lógica de negocio**: 70% yo (flujos, validaciones, estados)

## Errores corregidos

- Nullable types faltantes en modelos
- Token no persistía correctamente
- Memory leaks en providers
- Al comprar un ticket retornaba información no importante en EventDetail y lo quite
- **API endpoints incorrectos**: Le proporcioné el archivo Postman del backend para que se guíe en los servicios disponibles, pero aún así se confundió con la estructura de respuestas y endpoints. Tuve que corregir manualmente los repositories para usar la estructura correcta (`response.data['data']` vs `response.data['user']`) y casos parecidos

## Resultado

**Nota**: En este proyecto me demoré un poco más ya que decidí cambiar de Freezed a modelos manuales a mitad del desarrollo.

---

Juan Carlos Benavides - Diciembre 2025

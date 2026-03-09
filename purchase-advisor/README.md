# 🛍️ Purchase Advisor — Skill para Claude (Cowork)

Un agente de compras inteligentes que te ayuda a decidir si algo merece la pena comprarse, usando filtros de minimalismo, BIFL y coste real. Cuando decides que sí, documenta el análisis. Siempre guarda un log de la decisión.

---

## 🧠 ¿Qué hace?

Cuando le dices que estás pensando en comprar algo, el agente:

1. **Evalúa** si tiene sentido con 4 filtros: valor real, coste por uso, horas de trabajo y filosofía BIFL
2. **Debate** contigo — si empujas, te contraargumenta con datos
3. **Emite un veredicto**: ✅ SÍ / ❌ NO / ⏳ ESPERA
4. **Pregunta** si quieres un análisis en profundidad del producto (puntos fuertes, débiles, alternativas, dónde comprarlo)
5. **Crea una carpeta** con toda la documentación en tu directorio de compras

---

## 📁 Estructura de carpetas que genera

```
📂 2026-03-09 - Nuki Smart Lock Ultra/
├── LOG.md       → siempre: debate, filtros, veredicto
└── RESEARCH.md  → solo si lo pides: análisis del producto
```

---

## 🚀 Cómo instalarlo

### Requisitos
- [Claude Desktop](https://claude.ai/download) con **Cowork** activado

### Instalación

1. Descarga o clona este repo
2. Abre el archivo `purchase-advisor.skill` con Claude Desktop
3. Haz clic en **"Copy to your skills"**
4. Listo — el skill está disponible en cualquier sesión de Cowork

> El skill se activa automáticamente cuando mencionas que quieres comprar algo. No hace falta invocarlo manualmente.

---

## ⚙️ Personalización (importante)

El agente está pensado para adaptarse a **tu perfil**. Antes de usarlo, edita el archivo `purchase-advisor/references/AGENT.md` con tu información:

### Lo que tienes que rellenar

```
references/AGENT.md
```

- **Tu perfil**: filosofía de compra, estilo de vida, restricciones (ej: vegano, minimalista…)
- **Tus finanzas**: ingresos, gastos fijos, presupuesto discrecional mensual
- **Tu inventario**: qué tienes ya (tech, hogar, audio…) para evitar redundancias
- **Tu regla de horas**: `Precio ÷ (tu presupuesto discrecional / horas trabajadas al mes)`

### La regla de las X €/hora

Es el filtro más potente. Convierte cada compra en tiempo de vida:

```
Tasa = Presupuesto discrecional mensual ÷ Horas trabajadas efectivas al mes
```

Ejemplo: si tienes 1.000 €/mes discrecionales y trabajas ~149h efectivas → **~7 €/hora**. Unos auriculares de 210 € = 30 horas de curro. ¿Los vale?

Las horas efectivas se calculan así:
```
(52 semanas × 5 días - festivos - vacaciones) × 8h / 12 meses ≈ 149 h/mes
```

---

## 💬 Ejemplos de uso

```
"Estoy pensando en pillarme unos AirPods Pro 2, están a 229 €"
"¿Merece la pena suscribirme a Netflix ahora que sacaron X serie?"
"He visto una cafetera de 180 €, ¿debería comprarla?"
"Mira esto que he visto en Amazon [foto]"
```

El agente nunca busca productos desde cero — tú llegas con lo que tienes en mente, él evalúa.

---

## 📂 Estructura del skill

```
purchase-advisor/
├── SKILL.md                  → orquestador: flujo de trabajo del agente
├── references/
│   └── AGENT.md              → tu perfil, finanzas, inventario y marcos de decisión
└── templates/
    ├── LOG.md                → plantilla para el log de decisión
    └── RESEARCH.md           → plantilla para el análisis de producto
```

---

## 🔒 Privacidad

El archivo `references/AGENT.md` contiene información personal (finanzas, inventario). No lo subas a un repositorio público sin revisar. La plantilla incluida en este repo es un **ejemplo anónimo** — rellénala con tus datos antes de usar el skill.

---

## 📝 Licencia

MIT — úsalo, fórkalo, adáptalo.

#!/bin/bash

echo "🚀 Script de inicialización para el proyecto 'notas-rapidas'"

confirmar() {
  read -p "👉 $1 (s/n): " respuesta
  if [[ "$respuesta" != "s" ]]; then
    echo "⏭ Saltando '$1'"
    return 1
  fi
  return 0
}

# Paso 1: Crear proyecto Vite + React
if confirmar "Paso 1: Crear proyecto Vite + React"; then
  npm create vite@latest . -- --template react
fi

# Paso 2: Instalar dependencias
if confirmar "Paso 2: Instalar dependencias"; then
  npm install
fi

# Paso 3: Instalar TailwindCSS y otras herramientas
if confirmar "Paso 3: Instalar TailwindCSS y herramientas adicionales"; then
  npm install -D tailwindcss postcss autoprefixer
  npx tailwindcss init -p
fi

# Paso 4: Configurar TailwindCSS
if confirmar "Paso 4: Configurar TailwindCSS"; then
  cat > tailwind.config.js <<EOF
/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter', 'sans-serif']
      },
      colors: {
        info: '#3B82F6',
        warning: '#F59E0B',
        success: '#10B981',
      },
    },
  },
  plugins: [],
};
EOF
fi

# Paso 5: Agregar tipografía y estilos
if confirmar "Paso 5: Agregar tipografía y hoja de estilos base"; then
  mkdir -p src
  cat > src/index.css <<EOF
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  font-family: 'Inter', sans-serif;
}
EOF
fi

# Paso 6: Crear estructura React con barra lateral de letras
if confirmar "Paso 6: Crear estructura React básica con barra lateral derecha"; then
  mkdir -p src/components src/pages

  cat > src/components/Sidebar.jsx <<EOF
import React from 'react';
const letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
const colores = ['info', 'warning', 'success'];

export default function Sidebar() {
  return (
    <div className="fixed right-0 top-0 h-full w-16 flex flex-col items-center justify-center space-y-2 bg-gray-100 shadow">
      {letras.map((letra, index) => (
        <a
          key={letra}
          href={"#" + letra}
          className={\`text-white w-10 h-10 flex items-center justify-center rounded-full bg-\${colores[index % 3]}-500\`}
        >
          {letra}
        </a>
      ))}
    </div>
  );
}
EOF

  cat > src/App.jsx <<EOF
import React from 'react';
import Sidebar from './components/Sidebar';

function Nota({ titulo, texto, tipo }) {
  const colores = {
    info: 'bg-info-100 border-info-500',
    warning: 'bg-warning-100 border-warning-500',
    success: 'bg-success-100 border-success-500'
  };

  const estilo = colores[tipo] || colores.info;

  const fecha = new Date().toLocaleString();

  return (
    <div className={\`border-l-4 p-4 mb-4 \${estilo}\`}>
      <h3 className="font-bold">{titulo}</h3>
      <p className="text-sm">{texto}</p>
      <p className="text-xs mt-2 text-gray-600">{fecha}</p>
    </div>
  );
}

export default function App() {
  return (
    <div className="p-4 pr-20">
      <Sidebar />
      <h1 className="text-2xl font-bold mb-4">Notas Rápidas</h1>
      <Nota titulo="Nota Informativa" texto="Este es un ejemplo de nota informativa." tipo="info" />
      <Nota titulo="Nota de Advertencia" texto="Este es un ejemplo de advertencia." tipo="warning" />
      <Nota titulo="Nota Exitosa" texto="Este es un ejemplo de éxito." tipo="success" />
    </div>
  );
}
EOF
fi

# Paso 7: Configurar GitHub Pages
if confirmar "Paso 7: Configurar GitHub Pages"; then
  npm install gh-pages --save-dev

  sed -i '/"private": true/a "homepage": "https://automatizacion-it.github.io/notas-rapidas",' package.json

  npx json -I -f package.json -e 'this.scripts["predeploy"]="npm run build"'
  npx json -I -f package.json -e 'this.scripts["deploy"]="gh-pages -d dist"'
fi

echo "🎉 Script completado. Ejecuta 'npm run dev' para iniciar el proyecto."


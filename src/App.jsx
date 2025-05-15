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
    <div className={`border-l-4 p-4 mb-4 ${estilo}`}>
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

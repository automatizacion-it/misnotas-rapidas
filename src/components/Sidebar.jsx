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
          className={`text-white w-10 h-10 flex items-center justify-center rounded-full bg-${colores[index % 3]}-500`}
        >
          {letra}
        </a>
      ))}
    </div>
  );
}

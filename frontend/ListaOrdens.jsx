import { useEffect, useState } from 'react';

const API_BASE_URL = import.meta.env.VITE_API_URL || '';

export default function ListaOrdens() {
  const [ordens, setOrdens] = useState([]);

  useEffect(() => {
    const token = localStorage.getItem('token');
    fetch(`${API_BASE_URL}/api/ordens`, {
      headers: {
        Authorization: token
      }
    })
      .then(res => res.json())
      .then(data => setOrdens(data))
      .catch(err => console.error('Erro ao buscar ordens:', err));
  }, []);

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-4">Ordens de Serviço</h2>
      <ul>
        {ordens.map(ordem => (
          <li key={ordem.id} className="border-b py-2">
            <strong>{ordem.descricao}</strong> - Status: {ordem.status}
          </li>
        ))}
      </ul>
    </div>
  );
}

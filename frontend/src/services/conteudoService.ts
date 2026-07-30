import API_URL from "./api";

export async function buscarVersiculo() {

    const token = localStorage.getItem("token");

    const response = await fetch(
        `${API_URL}/v1/conteudos/random/cotidiano`,
        {
            headers: {
                Authorization: `Bearer ${token}`,
                "Content-Type": "application/json"
            }
        }
    );

    if (!response.ok) {
        throw new Error(`Erro HTTP: ${response.status}`);
    }

    return response.json();
}
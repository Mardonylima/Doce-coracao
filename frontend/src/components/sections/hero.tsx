"use client";

import { useEffect, useState } from "react";
import { buscarVersiculo } from "../../services/conteudoService";

export default function HeroSection() {
    const [versiculo, setVersiculo] = useState<any>("null");

    useEffect(() => {
        async function carregarVersiculo() {
            try {
                const data = await buscarVersiculo();
                setVersiculo(data);
            } catch (error) {
                console.error("Erro ao carregar versículo:", error);
            }
        }

        carregarVersiculo();
    }, []);

    return (
        <section className="hero" id="Inicio">
            <div className="container">
                <div className="row">
                    <div className="home-content">
                        <div className="contents">
                            <h2>Missão JHS</h2>

                            <p>
                                Habitar no Santuário do Doce Coração e ser uma vítima de oblação nos altares esquecidos
                            </p>

                            <p>Boas-vindas! Venha conhecer nosso Carisma!</p>
                        </div>

                        <div className="hero-actions">
                            <a href="#" className="btn btn-primary">
                                Visite-nos
                            </a>

                            <a href="#" className="btn btn-primary">
                                Sou novo aqui!
                            </a>
                        </div>

                        <div className="versiculo-diario">
                            <h3>Mensagem diária</h3>

                            <div className="frases-api">
                                {versiculo && (
                                    <>
                                        <h4>
                                            {versiculo.titulo}
                                        </h4>

                                        <p>
                                            {versiculo.conteudo}
                                        </p>

                                        <p>
                                            {versiculo.referencia}
                                        </p>
                                    </>
                                )}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    );
}
export default function AgendaSection() {
  return (
    <section className="section-agenda" id="agenda">
        <div className="container">

            <div className="agenda-intro">
                <h2>Atividades da comunidade</h2>
                <p>Confira os próximos eventos e venha participar</p>
            </div>

            <div className="eventos-grid">

                <article className="evento-card">
                    <div className="evento-img">
                        <img src="/images/Catedral.avif" alt="Pastoral SÃO DAMIÃO DE MOLOKAI" />
                        <span className="evento-badge">Pastoral</span>
                    </div>
                    <div className="evento-body">
                        <h3 className="evento-titulo">Pastoral São Damião de Molokai</h3>
                        <div className="evento-meta">
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Datas</span>
                                <ul className="evento-datas">
                                    <li>10/04 às 19h</li>
                                    <li>12/04 às 08h</li>
                                    <li>24/04 às 19h</li>
                                </ul>
                            </div>
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Local</span>
                                <p>Catedral Basílica de Nossa Senhora das Neves</p>
                            </div>
                        </div>
                        <p className="evento-descricao">Cada ato de bondade ao próximo é como se fosse feito ao próprio
                            Deus. Venha participar!</p>
                        <button type="button" className="btn btn-primary evento-btn"
                            aria-label="Inscrever-se em Missão de Rua">
                            Inscrever-se
                        </button>
                    </div>
                </article>

                <article className="evento-card">
                    <div className="evento-img">
                        <img src="/images/Eucaristia.avif" alt="Adoração Mensal" />
                        <span className="evento-badge">Oração</span>
                    </div>
                    <div className="evento-body">
                        <h3 className="evento-titulo">Perfeita oblação</h3>
                        <div className="evento-meta">
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Data</span>
                                <ul className="evento-datas">
                                    <li>11/04 às 19h</li>
                                </ul>
                            </div>
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Local</span>
                                <p>A definir</p>
                            </div>
                        </div>
                        <p className="evento-descricao">Junte-se a nós em adoração e oração mensal. Venha participar!</p>
                        <button type="button" className="btn btn-primary evento-btn"
                            aria-label="Inscrever-se em Adoração Mensal">
                            Inscrever-se
                        </button>
                    </div>
                </article>

                <article className="evento-card">
                    <div className="evento-img">
                        <img src="/images/Espiritualidade.avif" alt="Espiritualidade" />
                        <span className="evento-badge">Formação</span>
                    </div>
                    <div className="evento-body">
                        <h3 className="evento-titulo">Espiritualidade</h3>
                        <div className="evento-meta">
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Data</span>
                                <ul className="evento-datas">
                                    <li>25/04 às 19:30h</li>
                                </ul>
                            </div>
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Local</span>
                                <p>Centro Cultural Horizonte - João Pessoa, PB.</p>
                            </div>
                        </div>
                        <p className="evento-descricao">Descubra a profundidade da espiritualidade em nossa comunidade.</p>
                        <button type="button" className="btn btn-primary evento-btn"
                            aria-label="Inscrever-se em Espiritualidade">
                            Inscrever-se
                        </button>
                    </div>
                </article>

                <article className="evento-card">
                    <div className="evento-img">
                        <img src="/images/Outros_eventos.avif" alt="Outros eventos"/>
                        <span className="evento-badge evento-badge--neutro">Em breve</span>
                    </div>
                    <div className="evento-body">
                        <h3 className="evento-titulo">Outros eventos</h3>
                        <div className="evento-meta">
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Data</span>
                                <p>A definir</p>
                            </div>
                            <div className="evento-meta-item">
                                <span className="evento-meta-label">Local</span>
                                <p>A definir</p>
                            </div>
                        </div>
                        <p className="evento-descricao">Participe de nossos outros eventos e atividades.</p>
                        <button type="button" className="btn btn-primary evento-btn"
                            aria-label="Inscrever-se em outros eventos" disabled>
                            Em breve
                        </button>
                    </div>
                </article>

            </div>
        </div>
    </section>
  );
}
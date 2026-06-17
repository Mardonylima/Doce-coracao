export default function ContatoSection() {
  return (
    <section className="section-contato" id="contato">
        <div className="container">

            <div className="contato-intro">
                <h2>Faça parte</h2>
                <p>Há um lugar para você aqui, seja qual for o seu passo</p>
            </div>

            <div className="integracao-steps">
                <div className="step-card">
                    <div className="step-numero">01</div>
                    <h3 className="step-titulo">Venha a uma atividade</h3>
                    <p className="step-desc">Participe de uma Missão de Rua ou Adoração Mensal. Não precisa de nada — só
                        aparecer já é o começo.</p>
                    <a href="#agenda" className="btn btn-outline">Ver agenda</a>
                </div>

                <div className="step-card">
                    <div className="step-numero">02</div>
                    <h3 className="step-titulo">Conheça a equipe</h3>
                    <p className="step-desc">Nossa equipe está sempre disponível para conversar, tirar dúvidas e apresentar
                        o carisma da missão.</p>
                    <a href="https://wa.me/5583999999999" target="_blank" rel="noopener noreferrer"
                        className="btn btn-outline">Falar pelo WhatsApp</a>
                </div>

                <div className="step-card">
                    <div className="step-numero">03</div>
                    <h3 className="step-titulo">Integre-se à missão</h3>
                    <p className="step-desc">Descubra como seus dons e talentos podem servir à comunidade. Cada pessoa tem
                        um papel único aqui.</p>
                    <a href="https://www.instagram.com/docecoracaome/" target="_blank" rel="noopener noreferrer"
                        className="btn btn-outline">Siga no Instagram</a>
                </div>

            </div>

            <div className="contato-divisor">
                <span>ou contribua à distância</span>
            </div>

            <div className="contribuicao-grid">

                <div className="contribuicao-card">
                    <div className="contribuicao-icone contribuicao-icone--oracao"></div>
                    <h3>Ore por nós</h3>
                    <p>Envie um pedido de oração ou nos diga que está orando pela missão. Isso nos fortalece muito.</p>
                    <a href="#form-contato" className="btn btn-outline">Enviar mensagem</a>
                </div>

                <div className="contribuicao-card">
                    <div className="contribuicao-icone contribuicao-icone--voluntario"></div>
                    <h3>Seja voluntário</h3>
                    <p>Nas Missões de Rua, sempre precisamos de pessoas dispostas a servir.</p>
                    <a href="https://wa.me/5583999999999?text=Quero%20ser%20voluntário" target="_blank"
                        rel="noopener noreferrer" className="btn btn-outline">Quero ajudar</a>
                </div>

                <div className="contribuicao-card">
                    <div className="contribuicao-icone contribuicao-icone--doacao"></div>
                    <h3>Doe</h3>
                    <p>Seja um benfeitor das atividades da missão — desde materiais até a chegada às comunidades
                        mais distantes.</p>
                    <a href="#doacoes" className="btn btn-outline">Como doar</a>
                </div>

            </div>

            <div className="contato-grid">

                <div className="contato-form-area">
                    <form className="form-contato" id="form-contato" noValidate>
                        <h3>Fale com a gente</h3>
                        <p>Dúvidas, sugestões ou só um oi — estamos aqui.</p>

                        <div className="form-group">
                            <label htmlFor="nome">Nome</label>
                            <input 
                                type="text" 
                                className="form-control" 
                                id="nome" 
                                name="nome"
                                placeholder="Seu nome completo" 
                                required autoComplete="name" 
                                />
                        </div>

                        <div className="form-group">
                            <label htmlFor="email">E-mail</label>
                            <input 
                                type="email" 
                                className="form-control" 
                                id="email" 
                                name="email" 
                                placeholder="seu@email.com"
                                required autoComplete="email" 
                                />
                        </div>

                        <div className="form-group">
                            <label htmlFor="assunto">Assunto</label>
                            <select className="form-control" id="assunto" name="assunto">
                                <option value="">Selecione...</option>
                                <option value="visita">Quero visitar</option>
                                <option value="voluntario">Quero ser voluntário</option>
                                <option value="doacao">Quero fazer uma doação</option>
                                <option value="oracao">Pedido de oração</option>
                                <option value="outro">Outro assunto</option>
                            </select>
                        </div>

                        <div className="form-group">
                            <label htmlFor="mensagem">Mensagem</label>
                            <textarea className="form-control" id="mensagem" name="mensagem" rows={4}
                                placeholder="Como podemos ajudar?" required></textarea>
                        </div>

                        <button type="submit" className="btn btn-primary">
                            Enviar mensagem
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </section>
  );
}
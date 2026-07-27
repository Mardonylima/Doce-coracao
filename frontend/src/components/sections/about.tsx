export default function AboutSection() {
  return (
    <section className="section-sobre-nos" id="sobre-nos">
        <div className="container">
            <div className="sobre-content">
                <div className="sobre-intro">
                    <h2>Sobre nós</h2>
                    <p>O Doce Coração é uma comunidade de fé...</p>
                </div>

                <div className="sobre-cpb">
                    <div className="cpb-card">
                        <h3>Carisma</h3>
                        <p>Habitar no Santuário do Doce Coração...</p>
                    </div>
                    <div className="cpb-card">
                        <h3>Palavra Fundante</h3>
                        <p>Evangelho de São Mateus 28,1-10</p>
                    </div>
                    <div className="cpb-card">
                        <h3>Baluartes</h3>
                        <div className="section-carrossel" id="carrossel">
                            <div className="carrossel-track">
                                <div className="card">1</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
  );
}

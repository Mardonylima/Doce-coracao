export default function AboutSection() {
  return (
    <section className="section-sobre-nos" id="sobre-nos">
        <div className="container">
            <div className="sobre-content">
                <div className="sobre-intro">
                    <h2>Sobre nós</h2>
                    <p>O Doce Coração é uma comunidade de fé...</p>
                </div>

                <div className="sobre-mvv">
                    <div className="mvv-card">
                        <h3>Carisma</h3>
                        <p>Habitar no Santuário do Doce Coração...</p>
                    </div>
                    <div className="mvv-card">
                        <h3>palavra fundante</h3>
                        <p>Ser uma comunidade vibrante e acolhedora...</p>
                    </div>
                    <div className="mvv-card">
                        <h3>baluartes</h3>
                        <div className="section-carrossel" id="carrossel">
                            <div className="carrossel-track">
                                <div className="card">1</div>
                                <div className="card">2</div>
                                <div className="card">3</div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>
  );
}

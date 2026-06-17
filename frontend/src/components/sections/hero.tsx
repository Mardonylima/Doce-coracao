export default function HeroSection() {
  return (
    <section className="hero" id="Inicio">
            <div className="container">
                <div className="row">

                    <div className="home-content">
                        <div className="contents">
                            <h2>Missão JHS</h2>
                            <p>Habitar no Santuário do Doce Coração e ser uma vítima de oblação nos altares esquecidos
                            </p>
                            <p>Boas-vindas! Venha conhecer nosso Carisma!</p>
                        </div>

                        <div className="hero-actions">
                            <a href="#" className="btn btn-primary">Visite-nos</a>
                            <a href="#" className="btn btn-primary">Sou novo aqui!</a>
                        </div>

                        <div className="versiculo-diario">
                            <h3>Versículo do Dia</h3>
                            <p id="versiculo">
                                "O Senhor é o meu pastor; nada me faltará." - Salmo 23:1
                            </p>
                        </div>
                    </div>

                    <div className="home-img">                    
                        <div className="container-3d-home">
                        </div>

                    </div>
                </div>
            </div>
        </section>
  );
}
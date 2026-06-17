import React from "react"

import Navbar from "@/components/layout/navbar"
import Footer from "@/components/layout/footer"

import HeroSection from "@/components/sections/hero"
import AboutSection from "@/components/sections/about"
import AgendaSection from "@/components/sections/agenda"
import ContatoSection from "@/components/sections/contato"

export default function HomePage() {
  return (
    <>
      <Navbar />

      <main>
        <HeroSection /> 
        <AboutSection />
        <AgendaSection />
        <ContatoSection />
      </main>

      <Footer />
    </>
  );
}
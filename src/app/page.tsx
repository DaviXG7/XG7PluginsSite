"use client"
import "./body.scss";
import "./header.scss";
import "./footer.scss";

import { MainFooter, MainHeader } from "./templates"
import { Container } from 'postcss';



export default function Site() {
  return (
    <>
      <MainHeader />

      <main>
        content

        <button className="btn btn-primary">a</button>

      </main>

      <MainFooter />
    </>
    
  );
}
"use client"
import "./css/body.scss";

import { MainFooter, MainHeader } from "./templates"



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
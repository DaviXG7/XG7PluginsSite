"use client"
import { useState } from 'react';

import "../header.scss";
import "../footer.scss";

import { MainFooter, MainHeader } from "../templates"
import { redirect } from 'next/dist/server/api-utils';

export default function Site() {
    if (false) {
        
    }
    return (
      <>
        <MainHeader />
  
        <main>
          content
        </main>
  
        <MainFooter />
      </>
      
    );
  }
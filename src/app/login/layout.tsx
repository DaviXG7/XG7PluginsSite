import Logo from "../imgs/logo.png"

export const metadata = {
  title: 'Next.js',
  description: 'Generated by Next.js',
}

export default function RoostLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <head>
      <link rel="shortcut icon" type="image/png" href={ Logo.src }/>

        <title>Login</title>
      </head>
      <body>{children}</body>
    </html>
  )
}

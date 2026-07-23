import '../../styles/globals.css'; 

export default function RootLayout({
  children,
  }: Readonly<{
    children: React.ReactNode;
      }>) {
  return (
    <html lang="pt-br">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Missão JHS</title>
      </head>
      <body>{children}</body>
    </html>
  );
}
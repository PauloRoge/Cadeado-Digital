library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity digital_lock is
    Port ( entrada : in STD_LOGIC_VECTOR(3 downto 0);
           alterar : in STD_LOGIC;
           verificar : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR(3 downto 0);
           display : out STD_LOGIC_VECTOR(6 downto 0));
end digital_lock;

architecture hardware of digital_lock is
    signal senha_certa : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal senha_entrada : STD_LOGIC_VECTOR(3 downto 0);
    signal valor_display : STD_LOGIC_VECTOR(6 downto 0);

begin
    process(entrada, alterar, verificar)
    begin
        -- Salva a senha só quandpo o botao de alteração for pressionado.
        if rising_edge(alterar) then
            senha_certa <= entrada;
        end if;

        if verificar = '0' then
            -- caso o botão de verificação for pressionado, compara a senha inserida com a senha correta
            senha_entrada <= entrada;

            if senha_entrada = senha_certa then
                -- Senha correta, acenda todos os LEDs
                leds <= "1111";

                -- Converte o valor da senha para a representação de sete segmentos
                case senha_entrada is
                    when "0000" =>
                        valor_display <= "1000000";
                    when "0001" =>
                        valor_display <= "1111001";
                    when "0010" =>
                        valor_display <= "0100100";
                    when "0011" =>
                        valor_display <= "0110000";
                    when "0100" =>
                        valor_display <= "0011001";
                    when "0101" =>
                        valor_display <= "0010010";
                    when "0110" =>
                        valor_display <= "0000010";
                    when "0111" =>
                        valor_display <= "1111000";
                    when "1000" =>
                        valor_display <= "0000000";
                    when "1001" =>
                        valor_display <= "0010000";
                    when "1010" =>
                        valor_display <= "0001000";
                    when "1011" =>
                        valor_display <= "0000011";
                    when "1100" =>
                        valor_display <= "1000110"; 
                    when "1101" =>
                        valor_display <= "0100001";
                    when "1110" =>
                        valor_display <= "0000110";
                    when "1111" =>
                        valor_display <= "0001110";
                    when others =>
                        valor_display <= "1111111"; -- Todos os segmentos serão apagados
                end case;
            else
                -- Senha incorreta, apague todos os LEDs e o display
                leds <= "0000";
                valor_display <= "1111111"; -- Todos os segmentos apagados
            end if;
        else
            -- Nenhum botão pressionado ou alteração de senha concluída, mantenha os LEDs e o display apagados
            leds <= "0000";
            valor_display <= "1111111"; -- Todos os segmentos apagados
        end if;
    end process;

    -- Atribua o valor do display à saída correspondente
    display <= valor_display;

end hardware;

function [G_xx, G_yx, G_zx] = Green(vtm, vte, itm, ite, kx, ky, k_rho_2, zeta, k0);

    G_xx = -(vtm .* kx.^2 + vte .* ky.^2) ./ k_rho_2;
    G_yx = (vte - vtm).*kx.*ky./k_rho_2;
    G_zx = zeta .* kx/k0 .* itm;

end
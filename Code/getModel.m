function model = getModel(X_m, Y_m, a_m, b_m, s_m, type)
    model.type = type;
    model.X = X_m;
    model.Y = Y_m;
    model.a = a_m;
    model.b = b_m;
    model.s = s_m;
end
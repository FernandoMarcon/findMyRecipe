library("rjson")
filename = "/home/marcon/Documents/receitas.json"
receitas <- fromJSON(file = filename)

get_ingrediente <- function(receitas) {
    metodos = c()
    for(i in receitas$method) {
        if(length(grep("id",i)) > 0) {
            id = as.numeric(gsub('.*id','',i))
            i = gsub('id.*',receitas$ingredientes[id],i)
        }
        metodos = c(metodos,i)
    }
    return(metodos)
}

print_receita <- function(receita) {
    message("Nome: ",receita$name)
    message("Ingredients: \n",paste0('\t-',receita$ingredientes,'\n'))
    message("Metodo: \n",paste('\t-',get_ingrediente(receita),'\n'))
}
calc_score = function(receita, minha_cesta) {
    length(intersect(minha_cesta, receita$ingredientes))/length(receita$ingredientes)
}

print_receita(receitas)

minha_geladeira = c('water','coco','farinha integral')
meu_armario = c('water','oil','azeite','farinha integral','farinha de grao de bico')

calc_score(receitas,minha_geladeira)

calc_score(receitas,meu_armario)

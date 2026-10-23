module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.018800e+02> : tensor<3x6x1x2xf32>}> : () -> tensor<3x6x1x2xf32>
    %1 = tosa.exp %0 : (tensor<3x6x1x2xf32>) -> tensor<3x6x1x2xf32>
    %2 = tosa.concat %1, %1 {axis = 1 : i32} : (tensor<3x6x1x2xf32>, tensor<3x6x1x2xf32>) -> tensor<3x12x1x2xf32>
    %3 = tosa.tanh %2 : (tensor<3x12x1x2xf32>) -> tensor<3x12x1x2xf32>
    %4 = tosa.reciprocal %3 : (tensor<3x12x1x2xf32>) -> tensor<3x12x1x2xf32>
    %5 = tosa.reduce_product %4 {axis = 3 : i32} : (tensor<3x12x1x2xf32>) -> tensor<3x12x1x1xf32>
    %6 = tosa.maximum %5, %5 : (tensor<3x12x1x1xf32>, tensor<3x12x1x1xf32>) -> tensor<3x12x1x1xf32>
    %7 = tosa.reduce_product %6 {axis = 1 : i32} : (tensor<3x12x1x1xf32>) -> tensor<3x1x1x1xf32>
    %8 = tosa.reduce_product %7 {axis = 0 : i32} : (tensor<3x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %9 = tosa.exp %8 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %10 = tosa.exp %9 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %11 = tosa.tanh %10 : (tensor<1x1x1x1xf32>) -> tensor<1x1x1x1xf32>
    %cast = tensor.cast %11 : tensor<1x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}


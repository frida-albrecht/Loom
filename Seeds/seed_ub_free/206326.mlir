module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.247000e+01> : tensor<6x2xf32>}> : () -> tensor<6x2xf32>
    %1 = tosa.exp %0 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %2 = tosa.abs %1 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %3 = tosa.tanh %2 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %4 = tosa.identity %3 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<6x2xf32>) -> tensor<6x1xf32>
    %6 = tosa.argmax %5 {axis = 0 : i32} : (tensor<6x1xf32>) -> tensor<1xi32>
    %7 = tosa.logical_left_shift %6, %6 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %8 = tosa.exp %2 : (tensor<6x2xf32>) -> tensor<6x2xf32>
    %cast = tensor.cast %7 : tensor<1xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<6x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


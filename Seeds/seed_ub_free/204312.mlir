module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<144> : tensor<1x10x7x1xi32>}> : () -> tensor<1x10x7x1xi32>
    %1 = "tosa.const"() <{values = dense<101> : tensor<1x1x1x1xi32>}> : () -> tensor<1x1x1x1xi32>
    %2 = "tosa.const"() <{values = dense<-1.900500e+02> : tensor<8x2x10xf32>}> : () -> tensor<8x2x10xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<1x10x7x1xi32>, tensor<1x1x1x1xi32>) -> tensor<1x10x7x1xi32>
    %4 = tosa.argmax %3 {axis = 2 : i32} : (tensor<1x10x7x1xi32>) -> tensor<1x10x1xi32>
    %5 = tosa.reciprocal %2 : (tensor<8x2x10xf32>) -> tensor<8x2x10xf32>
    %6 = tosa.add %4, %4 : (tensor<1x10x1xi32>, tensor<1x10x1xi32>) -> tensor<1x10x1xi32>
    %7 = tosa.logical_left_shift %6, %6 : (tensor<1x10x1xi32>, tensor<1x10x1xi32>) -> tensor<1x10x1xi32>
    %8 = tosa.add %7, %4 : (tensor<1x10x1xi32>, tensor<1x10x1xi32>) -> tensor<1x10x1xi32>
    %cast = tensor.cast %5 : tensor<8x2x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %8 : tensor<1x10x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


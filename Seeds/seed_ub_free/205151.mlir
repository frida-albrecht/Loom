module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-154> : tensor<10x10x1xi32>}> : () -> tensor<10x10x1xi32>
    %1 = "tosa.const"() <{values = dense<1.694300e+02> : tensor<8x10xf32>}> : () -> tensor<8x10xf32>
    %2 = tosa.reduce_sum %0 {axis = 2 : i32} : (tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %3 = tosa.exp %1 : (tensor<8x10xf32>) -> tensor<8x10xf32>
    %4 = tosa.bitwise_or %2, %2 : (tensor<10x10x1xi32>, tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %5 = tosa.pow %3, %3 : (tensor<8x10xf32>, tensor<8x10xf32>) -> tensor<8x10xf32>
    %6 = tosa.intdiv %4, %2 : (tensor<10x10x1xi32>, tensor<10x10x1xi32>) -> tensor<10x10x1xi32>
    %cast = tensor.cast %5 : tensor<8x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<10x10x1xi32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


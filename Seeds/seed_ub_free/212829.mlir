module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-39> : tensor<5x6xi32>}> : () -> tensor<5x6xi32>
    %1 = "tosa.const"() <{values = dense<-6> : tensor<1x6xi32>}> : () -> tensor<1x6xi32>
    %2 = "tosa.const"() <{values = dense<1.356900e+02> : tensor<10x3xf32>}> : () -> tensor<10x3xf32>
    %3 = tosa.minimum %0, %1 : (tensor<5x6xi32>, tensor<1x6xi32>) -> tensor<5x6xi32>
    %4 = tosa.rsqrt %2 : (tensor<10x3xf32>) -> tensor<10x3xf32>
    %cast = tensor.cast %3 : tensor<5x6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<10x3xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


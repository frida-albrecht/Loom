module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-156> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<94> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<7.729000e+01> : tensor<10x2xf32>}> : () -> tensor<10x2xf32>
    %3 = "tosa.const"() <{values = dense<7.002000e+01> : tensor<1x1xf32>}> : () -> tensor<1x1xf32>
    %4 = tosa.bitwise_xor %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %5 = tosa.pow %2, %3 : (tensor<10x2xf32>, tensor<1x1xf32>) -> tensor<10x2xf32>
    %6 = tosa.pow %5, %5 : (tensor<10x2xf32>, tensor<10x2xf32>) -> tensor<10x2xf32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<10x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


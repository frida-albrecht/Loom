module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-9> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<-68> : tensor<i32>}> : () -> tensor<i32>
    %2 = "tosa.const"() <{values = dense<6.270000e+00> : tensor<9x5xf32>}> : () -> tensor<9x5xf32>
    %3 = tosa.intdiv %0, %1 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %4 = tosa.reciprocal %2 : (tensor<9x5xf32>) -> tensor<9x5xf32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<9x5xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


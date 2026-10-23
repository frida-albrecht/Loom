module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-13> : tensor<7xi32>}> : () -> tensor<7xi32>
    %1 = "tosa.const"() <{values = dense<-26> : tensor<7xi32>}> : () -> tensor<7xi32>
    %2 = "tosa.const"() <{values = dense<-1.947800e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %4 = tosa.bitwise_or %3, %3 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %5 = tosa.add %4, %3 : (tensor<7xi32>, tensor<7xi32>) -> tensor<7xi32>
    %6 = tosa.reciprocal %2 : (tensor<4xf32>) -> tensor<4xf32>
    %7 = tosa.reduce_min %6 {axis = 0 : i32} : (tensor<4xf32>) -> tensor<1xf32>
    %cast = tensor.cast %5 : tensor<7xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %7 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


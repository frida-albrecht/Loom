module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-35> : tensor<7x6xi32>}> : () -> tensor<7x6xi32>
    %1 = "tosa.const"() <{values = dense<1.666000e+02> : tensor<10x4x3x2xf32>}> : () -> tensor<10x4x3x2xf32>
    %2 = "tosa.const"() <{values = dense<-1.541200e+02> : tensor<10x1x3x2xf32>}> : () -> tensor<10x1x3x2xf32>
    %3 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<7x6xi32>) -> tensor<1x6xi32>
    %4 = tosa.pow %1, %2 : (tensor<10x4x3x2xf32>, tensor<10x1x3x2xf32>) -> tensor<10x4x3x2xf32>
    %cast = tensor.cast %3 : tensor<1x6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<10x4x3x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


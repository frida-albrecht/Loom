module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<10x1x6x6xi1>}> : () -> tensor<10x1x6x6xi1>
    %1 = "tosa.const"() <{values = dense<-6.371000e+01> : tensor<4x6x6xf32>}> : () -> tensor<4x6x6xf32>
    %2 = tosa.reduce_all %0 {axis = 1 : i32} : (tensor<10x1x6x6xi1>) -> tensor<10x1x6x6xi1>
    %3 = tosa.argmax %2 {axis = 0 : i32} : (tensor<10x1x6x6xi1>) -> tensor<1x6x6xi32>
    %4 = tosa.sigmoid %1 : (tensor<4x6x6xf32>) -> tensor<4x6x6xf32>
    %5 = tosa.abs %4 : (tensor<4x6x6xf32>) -> tensor<4x6x6xf32>
    %6 = tosa.abs %5 : (tensor<4x6x6xf32>) -> tensor<4x6x6xf32>
    %cast = tensor.cast %3 : tensor<1x6x6xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<4x6x6xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}


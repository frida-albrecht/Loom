module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<3> : tensor<6x8xi32>}> : () -> tensor<6x8xi32>
    %1 = "tosa.const"() <{values = dense<-8.536000e+01> : tensor<5x4x8xf32>}> : () -> tensor<5x4x8xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<6x8xi32>) -> tensor<8xi32>
    %3 = tosa.intdiv %2, %2 : (tensor<8xi32>, tensor<8xi32>) -> tensor<8xi32>
    %4 = tosa.log %1 : (tensor<5x4x8xf32>) -> tensor<5x4x8xf32>
    %5 = tosa.log %4 : (tensor<5x4x8xf32>) -> tensor<5x4x8xf32>
    %6 = tosa.reduce_max %4 {axis = 0 : i32} : (tensor<5x4x8xf32>) -> tensor<1x4x8xf32>
    %cast = tensor.cast %3 : tensor<8xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %5 : tensor<5x4x8xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<1x4x8xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


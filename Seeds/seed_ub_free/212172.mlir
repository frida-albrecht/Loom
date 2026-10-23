module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<true> : tensor<10xi1>}> : () -> tensor<10xi1>
    %1 = "tosa.const"() <{values = dense<179> : tensor<5xi32>}> : () -> tensor<5xi32>
    %2 = "tosa.const"() <{values = dense<-1.973300e+02> : tensor<7xf32>}> : () -> tensor<7xf32>
    %3 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10xi1>) -> tensor<i32>
    %4 = tosa.reduce_max %1 {axis = 0 : i32} : (tensor<5xi32>) -> tensor<1xi32>
    %5 = tosa.log %2 : (tensor<7xf32>) -> tensor<7xf32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<1xi32> to tensor<*xi32>
    %cast_1 = tensor.cast %5 : tensor<7xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}


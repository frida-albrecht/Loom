module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-6.372000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = tosa.floor %0 : (tensor<6xf32>) -> tensor<6xf32>
    %2 = tosa.minimum %1, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %3 = tosa.equal %2, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xi1>
    %4 = tosa.ceil %2 : (tensor<6xf32>) -> tensor<6xf32>
    %5 = tosa.maximum %2, %2 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %6 = tosa.argmax %3 {axis = 0 : i32} : (tensor<6xi1>) -> tensor<i32>
    %7 = tosa.maximum %1, %1 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %4 : tensor<6xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<6xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %6 : tensor<i32> to tensor<*xi32>
    %cast_2 = tensor.cast %7 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_1) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}


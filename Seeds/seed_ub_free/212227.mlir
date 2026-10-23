module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-149> : tensor<3x9x4xi32>}> : () -> tensor<3x9x4xi32>
    %1 = "tosa.const"() <{values = dense<173> : tensor<3x4x10xi32>}> : () -> tensor<3x4x10xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %4 = tosa.matmul %0, %1, %2, %3 : (tensor<3x9x4xi32>, tensor<3x4x10xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<3x9x10xi32>
    %5 = tosa.equal %4, %4 : (tensor<3x9x10xi32>, tensor<3x9x10xi32>) -> tensor<3x9x10xi1>
    %6 = tosa.reduce_any %5 {axis = 1 : i32} : (tensor<3x9x10xi1>) -> tensor<3x1x10xi1>
    %7 = tosa.argmax %6 {axis = 2 : i32} : (tensor<3x1x10xi1>) -> tensor<3x1xi32>
    %cast = tensor.cast %7 : tensor<3x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


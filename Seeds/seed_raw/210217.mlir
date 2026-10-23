module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<45> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<94> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.greater_equal %0, %1 : (tensor<10xi32>, tensor<1xi32>) -> tensor<10xi1>
    %3 = tosa.concat %2, %2 {axis = 0 : i32} : (tensor<10xi1>, tensor<10xi1>) -> tensor<20xi1>
    %4 = tosa.reverse %3 {axis = 0 : i32} : (tensor<20xi1>) -> tensor<20xi1>
    %5 = tosa.argmax %4 {axis = 0 : i32} : (tensor<20xi1>) -> tensor<i32>
    %6 = tosa.const_shape  {values = dense<1> : tensor<2xindex>} : () -> !tosa.shape<2>
    %7 = tosa.reshape %5, %6 : (tensor<i32>, !tosa.shape<2>) -> tensor<1x1xi32>
    %8 = tosa.clz %7 : (tensor<1x1xi32>) -> tensor<1x1xi32>
    %cast = tensor.cast %8 : tensor<1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<16> : tensor<3x9x9x1xi32>}> : () -> tensor<3x9x9x1xi32>
    %1 = "tosa.const"() <{values = dense<-192> : tensor<3x9x9x100xi32>}> : () -> tensor<3x9x9x100xi32>
    %2 = tosa.concat %0, %1 {axis = 3 : i32} : (tensor<3x9x9x1xi32>, tensor<3x9x9x100xi32>) -> tensor<3x9x9x101xi32>
    %3 = tosa.bitwise_xor %2, %2 : (tensor<3x9x9x101xi32>, tensor<3x9x9x101xi32>) -> tensor<3x9x9x101xi32>
    %4 = tosa.reduce_min %3 {axis = 2 : i32} : (tensor<3x9x9x101xi32>) -> tensor<3x9x1x101xi32>
    %5 = tosa.abs %4 : (tensor<3x9x1x101xi32>) -> tensor<3x9x1x101xi32>
    %cast = tensor.cast %5 : tensor<3x9x1x101xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}


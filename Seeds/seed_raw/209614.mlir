module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-82> : tensor<4x4x10xi16>}> : () -> tensor<4x4x10xi16>
    %1 = "tosa.const"() <{values = dense<false> : tensor<9x5x2x3xi1>}> : () -> tensor<9x5x2x3xi1>
    %2 = "tosa.const"() <{values = dense<[0, 2, 1]> : tensor<3xi32>}> : () -> tensor<3xi32>
    %3 = tosa.transpose %0 {perms = array<i32: 0, 2, 1>} : (tensor<4x4x10xi16>) -> tensor<4x10x4xi16>
    %4 = tosa.reduce_any %1 {axis = 1 : i32} : (tensor<9x5x2x3xi1>) -> tensor<9x1x2x3xi1>
    %5 = tosa.argmax %4 {axis = 2 : i32} : (tensor<9x1x2x3xi1>) -> tensor<9x1x3xi32>
    %cast = tensor.cast %3 : tensor<4x10x4xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %5 : tensor<9x1x3xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}


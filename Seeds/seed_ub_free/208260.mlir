module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI64(tensor<*xi64>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-111> : tensor<5x3x9x4xi16>}> : () -> tensor<5x3x9x4xi16>
    %1 = "tosa.const"() <{values = dense<149> : tensor<9x8x4x9xi64>}> : () -> tensor<9x8x4x9xi64>
    %2 = "tosa.const"() <{values = dense<-146> : tensor<1x1x1x1xi64>}> : () -> tensor<1x1x1x1xi64>
    %3 = tosa.reverse %0 {axis = 3 : i32} : (tensor<5x3x9x4xi16>) -> tensor<5x3x9x4xi16>
    %4 = tosa.minimum %1, %2 : (tensor<9x8x4x9xi64>, tensor<1x1x1x1xi64>) -> tensor<9x8x4x9xi64>
    %5 = tosa.concat %3, %3 {axis = 0 : i32} : (tensor<5x3x9x4xi16>, tensor<5x3x9x4xi16>) -> tensor<10x3x9x4xi16>
    %cast = tensor.cast %4 : tensor<9x8x4x9xi64> to tensor<*xi64>
    %cast_0 = tensor.cast %5 : tensor<10x3x9x4xi16> to tensor<*xi16>
    call @printMemrefI64(%cast) : (tensor<*xi64>) -> ()
    call @printMemrefI16(%cast_0) : (tensor<*xi16>) -> ()
    return
  }
}

